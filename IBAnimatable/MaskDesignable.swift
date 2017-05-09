//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

/// A protocol provides mask designable feature.
public protocol MaskDesignable: class {
  /**
   The type of the mask used for masking an IBAnimatable UI element.

   When you create a class and conform to `MaskDesignable`, you need to implement this computed property like

   ```
   public var maskType: MaskType = .none {
     didSet {
       configureMask()
       configureBorder()
     }
   }
   ```

   Because Interface Builder doesn't support `enum` for `@IBInspectable` property. You need to create an `internal` property using optional String as the type like
   ```
   @IBInspectable var _maskType: String? {
     didSet {
       maskType = MaskType(string: _maskType)
     }
   }
   ```
   */
  var maskType: MaskType { get set }
}

public extension MaskDesignable where Self: UIView {
  /// Mask the IBAnimatable UI element with provided `maskType`
  public func configureMask(previousMaskType: MaskType) {
    switch maskType {
    case .circle:
      maskCircle()
    case let .parallelogram(angle):
      maskParallelogram(with: angle)
    case let .polygon(sides):
      maskPolygon(with: sides)
    case let .star(points):
      maskStar(with: points )
    case let .wave(direction, width, offset):
      maskWave(with: direction, width: width, offset: offset)
    case .triangle:
      maskTriangle()
    case let .custom(pathProvider):
      maskCustom(with: pathProvider)
    case .none:
      // If `previousMaskType` is `.none`, then we will **not** remove `layer.mask` before re-adding it. This allows for custom masks to be preserved.
      if case .none = previousMaskType {
        return
      } else {
          layer.mask?.removeFromSuperlayer()
      }
    }
  }
}

// MARK: - Private mask functions
private extension MaskDesignable where Self: UIView {
  // MARK: - Circle

  /// Mask a circle shape.
  func maskCircle() {
    let diameter = ceil(min(bounds.width, bounds.height))
    let origin = CGPoint(x: (bounds.width - diameter) / 2.0, y: (bounds.height - diameter) / 2.0)
    let size = CGSize(width: diameter, height: diameter)
    let circlePath = UIBezierPath(ovalIn: CGRect(origin: origin, size: size))
    draw(circlePath)
  }

  // MARK: - Polygon

  /**
   Mask a polygon shape.

   - Parameter sides: The number of the polygon sides.
   */
  func maskPolygon(with sides: Int) {
    let polygonPath = getPolygonBezierPath(with: max(sides, 3))
    draw(polygonPath)
  }

  /**
   Get a Bezier path for a polygon shape with provided sides.

   - Parameter sides: The number of the polygon sides.
   - Returns: A Bezier path for a polygon shape.
   */
  func getPolygonBezierPath(with sides: Int) -> UIBezierPath {
    let path = UIBezierPath()
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle: CGFloat = -.pi / 2
    let angleIncrement = .pi * 2 / CGFloat(sides)
    let length = min(bounds.width, bounds.height)
    let radius = length / 2.0

    path.move(to: point(from: angle, radius: radius, offset: center))
    for _ in 1...sides - 1 {
      angle += angleIncrement
      path.addLine(to: point(from: angle, radius: radius, offset: center))
    }
    path.close()
    return path
  }

  // MARK: - Star

  /**
   Mask a star shape.

   - Parameter points: The number of the star points.
   */
  func maskStar(with points: Int) {
    // FIXME: Do not mask the shadow.

    // Stars must has at least 3 points.
    var starPoints = points
    if points <= 2 {
      starPoints = 5
    }

    let path = getStarPath(with: starPoints)
    draw(path)
  }

  /**
   Get a Bezier path for a star shape with provided points.

   - Parameter sides: The number of the star points.
   - Returns: A Bezier path for a star shape.
   */
  func getStarPath(with points: Int, borderWidth: CGFloat = 0) -> UIBezierPath {
    let path = UIBezierPath()
    let radius = min(bounds.size.width, bounds.size.height) / 2 - borderWidth
    let starExtrusion = radius / 2
    let angleIncrement = .pi * 2 / CGFloat(points)
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle: CGFloat = -.pi / 2
    for _ in 1...points {
      let aPoint = point(from: angle, radius: radius, offset: center)
      let nextPoint = point(from: angle + angleIncrement, radius: radius, offset: center)
      let midPoint = point(from: angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)

      if path.isEmpty {
        path.move(to: aPoint)
      }

      path.addLine(to: midPoint)
      path.addLine(to: nextPoint)
      angle += angleIncrement
    }

    path.close()
    return path
  }

  // MARK: - Parallelogram

  /**
   Mask a parallelogram shape with provided top-left angle.

   - Parameter topLeftAngle: The top-left angle of the parallelogram shape.
   */
  func maskParallelogram(with topLeftAngle: Double) {
    let parallelogramPath = getParallelogramBezierPath(with: topLeftAngle)
    draw(parallelogramPath)
  }

  /**
   Get a Bezier path for a parallelogram shape with provided top-left angle.

   - Parameter sides: The top-left angle of the parallelogram shape.
   - Returns: A Bezier path for a parallelogram shape.
   */
  func getParallelogramBezierPath(with topLeftAngle: Double) -> UIBezierPath {
    let topLeftAngleRad = topLeftAngle * .pi / 180
    let path = UIBezierPath()
    let offset = abs(CGFloat(tan(topLeftAngleRad - .pi / 2)) * bounds.height)

    if topLeftAngle <= 90 {
      path.move(to: CGPoint(x: 0, y: 0))
      path.addLine(to: CGPoint(x: bounds.width - offset, y: 0))
      path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
      path.addLine(to: CGPoint(x: offset, y: bounds.height))
    } else {
      path.move(to: CGPoint(x: offset, y: 0))
      path.addLine(to: CGPoint(x: bounds.width, y: 0))
      path.addLine(to: CGPoint(x: bounds.width - offset, y: bounds.height))
      path.addLine(to: CGPoint(x: 0, y: bounds.height))
    }
    path.close()
    return path
  }

  // MARK: - Triangle

  /**
   Mask a triangle shape.
   */
  func maskTriangle() {
    let trianglePath = getTriangleBezierPath()
    draw(trianglePath)
  }

  /**
   Get a Bezier path for a triangle shape.

   - Returns: A Bezier path for a triangle shape.
   */
  func getTriangleBezierPath() -> UIBezierPath {
    let path = UIBezierPath()

    path.move(to: CGPoint(x: bounds.width / 2.0, y: bounds.origin.y))
    path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
    path.addLine(to: CGPoint(x: bounds.origin.x, y: bounds.height))
    path.close()
    return path
  }

  // MARK: - Wave

  /**
   Mask a wave shape with provided prameters.

   - Parameter direction: The direction of the wave shape.
   - Parameter width: The width of the wave shape.
   - Parameter offset: The offset of the wave shape.
   */
  func maskWave(with direction: MaskType.WaveDirection, width: Double, offset: Double) {
    let wavePath = getWaveBezierPath(with: direction == .up, width: CGFloat(width), offset: CGFloat(offset))
    draw(wavePath)
  }

  /**
   Get a Bezier path for a parallelogram wave with provided prameters.

   - Parameter isUp: The flag to indicate whether the wave is up or not.
   - Parameter width: The width of the wave shape.
   - Parameter offset: The offset of the wave shape.

   - Returns: A Bezier path for a wave shape.
   */
  func getWaveBezierPath(with isUp: Bool, width: CGFloat, offset: CGFloat) -> UIBezierPath {
    let originY = isUp ? bounds.maxY : bounds.minY
    let halfWidth = width / 2.0
    let halfHeight = bounds.height / 2.0
    let quarterWidth = width / 4.0

    var isUp = isUp
    var startX = bounds.minX - quarterWidth - (offset.truncatingRemainder(dividingBy: width))
    var endX = startX + halfWidth

    let path = UIBezierPath()
    path.move(to: CGPoint(x: startX, y: originY))
    path.addLine(to: CGPoint(x: startX, y: bounds.midY))

    repeat {
      path.addQuadCurve(
        to: CGPoint(x: endX, y: bounds.midY),
        controlPoint: CGPoint(
          x: startX + quarterWidth,
          y: isUp ? bounds.maxY + halfHeight : bounds.minY - halfHeight)
      )
      startX = endX
      endX += halfWidth
      isUp = !isUp
    } while startX < bounds.maxX

    path.addLine(to: CGPoint(x: path.currentPoint.x, y: originY))
    return path
  }

  func maskCustom(with provider: CustomMaskProvider) {
    draw(provider(bounds.size))
  }
}

// MARK: - Private helper functions
private extension MaskDesignable where Self: UIView {
  /**
   Draw a Bezier path on `layer.mask` using `CAShapeLayer`.

   - Parameter path: The Bezier path to draw.
   */
  func draw(_ path: UIBezierPath) {
    layer.mask?.removeFromSuperlayer()

    let maskLayer = CAShapeLayer()
    maskLayer.frame = CGRect(origin: .zero, size: bounds.size)
    maskLayer.path = path.cgPath
    layer.mask = maskLayer
  }

  /**
   Return a radian from a provided degree a Bezier path on `layer.mask` using `CAShapeLayer`.

   - Parameter degree: The degree to convert.

   - Returns: A radian converted from the provided degree.
   */
  func degree2radian(degree: CGFloat) -> CGFloat {
    return .pi * degree / 180
  }

  /**
   Return a CGPoint from provided parameters.

   - Parameter angle: The angle to determine a point.
   - Parameter radius: The radius to determine a point.
   - Parameter offset: The offset to determine a point.

   - Returns: A CGPoint based on provided parameters.
   */
  func point(from angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
    return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
  }
}
