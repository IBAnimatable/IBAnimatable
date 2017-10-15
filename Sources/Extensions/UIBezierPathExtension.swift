//
//  Created by phimage on 18/05/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit

extension UIBezierPath {

  // MARK: - Circle

  /**
   Create a Bezier path for a circle shape.
   
   - Parameter bounds: The bounds of shape.
   */
  convenience init(circleIn bounds: CGRect) {
    let diameter = ceil(min(bounds.width, bounds.height))
    let origin = CGPoint(x: (bounds.width - diameter) / 2.0, y: (bounds.height - diameter) / 2.0)
    let size = CGSize(width: diameter, height: diameter)
    self.init(ovalIn: CGRect(origin: origin, size: size))
  }

  // MARK: - Triangle

  /**
   Create a Bezier path for a triangle shape.
   */
  convenience init(triangleIn bounds: CGRect) {
    self.init()
    move(to: CGPoint(x: bounds.width / 2.0, y: bounds.origin.y))
    addLine(to: CGPoint(x: bounds.width, y: bounds.height))
    addLine(to: CGPoint(x: bounds.origin.x, y: bounds.height))
    close()
  }

  // MARK: - Polygon

  /**
   Create a Bezier path for a polygon shape with provided sides.
   
   - Parameter bounds: The bounds of shape.
   - Parameter sides: The number of the polygon sides.
   */
  convenience init(polygonIn bounds: CGRect, with sides: Int) {
    self.init()
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle: CGFloat = -.pi / 2
    let angleIncrement = .pi * 2 / CGFloat(sides)
    let length = min(bounds.width, bounds.height)
    let radius = length / 2.0

    move(to: point(from: angle, radius: radius, offset: center))
    for _ in 1...sides - 1 {
      angle += angleIncrement
      self.addLine(to: point(from: angle, radius: radius, offset: center))
    }
    close()
  }

  // MARK: - Parallelogram

  /**
   Create a Bezier path for a parallelogram shape with provided top-left angle.
   
   - Parameter bounds: The bounds of shape.
   - Parameter topLeftAngle: The top-left angle of the parallelogram shape.
   */
  convenience init(parallelogramIn bounds: CGRect, with topLeftAngle: Double) {
    self.init()
    let topLeftAngleRad = topLeftAngle * .pi / 180

    let offset = abs(CGFloat(tan(topLeftAngleRad - .pi / 2)) * bounds.height)

    if topLeftAngle <= 90 {
      move(to: CGPoint(x: 0, y: 0))
      addLine(to: CGPoint(x: bounds.width - offset, y: 0))
      addLine(to: CGPoint(x: bounds.width, y: bounds.height))
      addLine(to: CGPoint(x: offset, y: bounds.height))
    } else {
      move(to: CGPoint(x: offset, y: 0))
      addLine(to: CGPoint(x: bounds.width, y: 0))
      addLine(to: CGPoint(x: bounds.width - offset, y: bounds.height))
      addLine(to: CGPoint(x: 0, y: bounds.height))
    }
    close()
  }

  // MARK: - Wave

  /**
   Create a Bezier path for a parallelogram wave with provided prameters.

   - Parameter bounds: The bounds of shape.
   - Parameter isUp: The flag to indicate whether the wave is up or not.
   - Parameter width: The width of the wave shape.
   - Parameter offset: The offset of the wave shape.
   */
  convenience init(waveIn bounds: CGRect, with isUp: Bool, width: CGFloat, offset: CGFloat) {
    self.init()
    let originY = isUp ? bounds.maxY : bounds.minY
    let halfWidth = width / 2.0
    let halfHeight = bounds.height / 2.0
    let quarterWidth = width / 4.0

    var isUp = isUp
    var startX = bounds.minX - quarterWidth - (offset.truncatingRemainder(dividingBy: width))
    var endX = startX + halfWidth

    move(to: CGPoint(x: startX, y: originY))
    addLine(to: CGPoint(x: startX, y: bounds.midY))

    repeat {
      addQuadCurve(
        to: CGPoint(x: endX, y: bounds.midY),
        controlPoint: CGPoint(
          x: startX + quarterWidth,
          y: isUp ? bounds.maxY + halfHeight : bounds.minY - halfHeight)
      )
      startX = endX
      endX += halfWidth
      isUp = !isUp
    } while startX < bounds.maxX

    addLine(to: CGPoint(x: currentPoint.x, y: originY))
  }

  // MARK: - Star

  /**
   Create a Bezier path for a star shape with provided points.
   
   - Parameter bounds: The bounds of shape.
   - Parameter sides: The number of the star points.
   */
  convenience init(starIn bounds: CGRect, with points: Int, borderWidth: CGFloat = 0) {
    self.init()
    // Stars must has at least 3 points.
    var starPoints = points
    if points <= 2 {
      starPoints = 5
    }

    let radius = min(bounds.size.width, bounds.size.height) / 2 - borderWidth
    let starExtrusion = radius / 2
    let angleIncrement = .pi * 2 / CGFloat(starPoints)
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle: CGFloat = -.pi / 2
    for _ in 1...starPoints {
      let aPoint = point(from: angle, radius: radius, offset: center)
      let nextPoint = point(from: angle + angleIncrement, radius: radius, offset: center)
      let midPoint = point(from: angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)

      if isEmpty {
        move(to: aPoint)
      }

      addLine(to: midPoint)
      addLine(to: nextPoint)
      angle += angleIncrement
    }

    close()
  }
}

private extension UIBezierPath {
  func point(from angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
    return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
  }
}
