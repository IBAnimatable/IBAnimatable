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

  /**
   Create a Bezier path for a heart shape.

   - Parameter bounds: The bounds of shape.
   */
  convenience init(heartIn bounds: CGRect) {
    self.init()
    let (x, y, width, height) = bounds.centeredSquare.flatten()

    let lowerPoint = CGPoint(x: x + width / 2, y: (y + height ))
    move(to: lowerPoint)

    addCurve(to: CGPoint(x: x, y: (y + (height / 4))),
             controlPoint1: CGPoint(x: (x + (width / 2)), y: (y + (height * 3 / 4))),
             controlPoint2: CGPoint(x: x, y: (y + (height / 2))))

    addArc(withCenter: CGPoint(x: (x + (width / 4)), y: (y + (height / 4))),
           radius: (width / 4),
           startAngle: .pi,
           endAngle: 0,
           clockwise: true)

    addArc(withCenter: CGPoint(x: (x + (width * 3 / 4)), y: (y + (height / 4))),
           radius: (width / 4),
           startAngle: .pi,
           endAngle: 0,
           clockwise: true)

    addCurve(to: lowerPoint,
             controlPoint1: CGPoint(x: (x + width), y: (y + (height / 2))),
             controlPoint2: CGPoint(x: (x + (width / 2)), y: (y + (height * 3 / 4))))
  }

  /**
   Create a Bezier path for a ring shape.
   
   - Parameter bounds: The bounds of shape.
   - Parameter radius: The radius of the shape.
   */
  convenience init(ringIn bounds: CGRect, radius: CGFloat) {
    let center = bounds.center
    let (innerRadius, outerRadius) = bounds.radii(for: radius)

    self.init()
    addArc(withCenter: .zero, radius: innerRadius, startAngle: 0, endAngle: .pi * 2, clockwise: true)

    move(to: CGPoint(x: outerRadius, y: 0))

    addArc(withCenter: .zero, radius: outerRadius, startAngle: 0, endAngle: .pi * 2, clockwise: true)

    self.translate(to: center)
    usesEvenOddFillRule = true
  }

  /**
   Create a Bezier path for a gear shape.

   - Parameter bounds: The bounds of shape.
   - Parameter radius: The radius of the shape.
   - Parameter cogs: The number of cogs (min: 2)
   */
  convenience init(gearIn bounds: CGRect, radius: CGFloat, cogs: Int) {
    let center = bounds.center
    let (innerRadius, outerRadius) = bounds.radii(for: radius)

    self.init()

    guard cogs > 2 else {
      return
    }

    let angle: CGFloat = .pi / CGFloat(cogs)
    var radius = (outerRadius, innerRadius)

    addArc(withCenter: .zero, radius: innerRadius / 2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
    move(to: CGPoint(x: radius.0, y: 0))

    for _ in 0..<cogs * 2 {
      addArc(withCenter: .zero, radius: radius.0, startAngle: 0, endAngle: -angle, clockwise: false)
      apply(CGAffineTransform(rotationAngle: angle))
      swap(&radius.0, &radius.1)
    }

    self.translate(to: center)
  }

  /**
   Create a Bezier path for a super ellipse shape.
   https://en.wikipedia.org/wiki/Superellipse

   - Parameter bounds: The bounds of shape.
   - Parameter n: The super ellipse main parameter.
   */
  convenience init(superEllipseInRect bounds: CGRect, n: CGFloat = CGFloat.𝑒) {
    let a = bounds.width / 2
    let b = bounds.height / 2
    let n_2 = 2 / n
    let center = bounds.center
    let centerLeft = CGPoint(x: bounds.origin.x, y: bounds.midY)

    let x = { (t: CGFloat) -> CGFloat in
      let cost = cos(t)
      return center.x + cost.sign() * a * pow(abs(cost), n_2)
    }

    let y = { (t: CGFloat) -> CGFloat in
      let sint = sin(t)
      return center.y + sint.sign() * b * pow(abs(sint), n_2)
    }

    self.init()
    move(to: centerLeft)

    let factor = max((a + b) / 10, 32)
    for t in stride(from: (-CGFloat.pi), to: CGFloat.pi, by: CGFloat.pi / factor) {
      addLine(to: CGPoint(x: x(t), y: y(t)))
    }
    close()
  }

  /**
   Create a Bezier path for a drop shape.
   
   - Parameter bounds: The bounds of shape.
   */
  convenience init(dropInRect bounds: CGRect) {
    self.init()
    let (x, y, width, height) = bounds.centeredSquare.flatten()

    let topPoint = CGPoint(x: x + width / 2, y: 0)
    move(to: topPoint)

    addCurve(to: CGPoint(x: x + width / 8, y: (y + (height * 5 / 8))),
             controlPoint1: CGPoint(x: x + width / 2, y: height / 8),
             controlPoint2: CGPoint(x: x + width / 8, y: (y + (height * 3 / 8))))

    addArc(withCenter: CGPoint(x: (x + (width / 2)), y: (y + (height * 5 / 8))),
           radius: (width * 3 / 8),
           startAngle: .pi,
           endAngle: 0,
           clockwise: false)

    addCurve(to: topPoint,
             controlPoint1: CGPoint(x: x + width * 7 / 8, y: (y + (height * 3 / 8))),
             controlPoint2: CGPoint(x: x + width / 2, y: height / 8))
  }

  /**
   Create a Bezier path for a plus sign shape.
   
   - Parameter bounds: The bounds of shape.
   */
  convenience init(plusSignInRect bounds: CGRect, width signWidth: CGFloat) {
    self.init()

    let (x, y, width, height) = bounds/*.centeredSquare*/.flatten()
    if signWidth > width {
      return
    }
    let midX = x + width / 2
    let midY = y + height / 2
    let right = x + width
    let left = x
    let top = y
    let bottom = y + height

    move(to: CGPoint(x: midX - signWidth / 2, y: top))
    addLine(to: CGPoint(x: midX + signWidth / 2, y: top))
    addLine(to: CGPoint(x: midX + signWidth / 2, y: midY - signWidth / 2))
    addLine(to: CGPoint(x: right, y: midY - signWidth / 2))
    addLine(to: CGPoint(x: right, y: midY + signWidth / 2))
    addLine(to: CGPoint(x: midX + signWidth / 2, y: midY + signWidth / 2))
    addLine(to: CGPoint(x: midX + signWidth / 2, y: bottom))
    addLine(to: CGPoint(x: midX - signWidth / 2, y: bottom))
    addLine(to: CGPoint(x: midX - signWidth / 2, y: midY + signWidth / 2))
    addLine(to: CGPoint(x: left, y: midY + signWidth / 2))
    addLine(to: CGPoint(x: left, y: midY - signWidth / 2))
    addLine(to: CGPoint(x: midX - signWidth / 2, y: midY - signWidth / 2))
    addLine(to: CGPoint(x: midX - signWidth / 2, y: top))
  }

  /**
   Create a Bezier path for a moon shape.
   
   - Parameter bounds: The bounds of shape.
   - Parameter angle: The angle.
   */
  convenience init(moonInRect bounds: CGRect, with angle: CGFloat) {
    self.init()
    let radius = ceil(min(bounds.width, bounds.height) / 2)
    let radian: CGFloat
    if angle > 0 && angle < 180 {
      radian = -angle * .pi / 180
    } else {
      radian = -90 * .pi / 180
    }

    addArc(withCenter: .zero, radius: radius, startAngle: -radian / 2, endAngle: radian / 2, clockwise: true)

    if angle > 0 && angle < 180 {
      addArc(withCenter: CGPoint(x: radius * cos(radian / 2.0), y: 0.0),
             radius: radius * sin(radian / 2.0), startAngle: CGFloat.pi / 2, endAngle: -CGFloat.pi / 2.0, clockwise: false)
    } else {
      addLine(to: .zero)
    }

    close()
    self.translate(to: bounds.center)
  }
}

private extension UIBezierPath {
  func point(from angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
    return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
  }
  func translate(tx: CGFloat, ty: CGFloat) {
    apply(CGAffineTransform(translationX: tx, y: ty))
  }
  func translate(to point: CGPoint) {
    apply(CGAffineTransform(translationX: point.x, y: point.y))
  }
  func rotate(with theta: CGFloat, around origine: CGPoint = .zero) {
    guard theta != 0 else {
      return
    }
    if origine != .zero {
      translate(to: CGPoint(x: -origine.x, y: -origine.y))
    }
    apply(CGAffineTransform(rotationAngle: theta))
    if origine != .zero {
      translate(to: origine)
    }
  }
}

extension CGFloat {
  static let 𝑒 = CGFloat(M_E)

  func sign() -> CGFloat {
    if self < 0 {
      return -1
    } else if self > 0 {
      return 1
    } else {
      return 0
    }
  }
}

private extension CGRect {
  var center: CGPoint {
    return CGPoint(x: self.midX, y: self.midY)
  }
  var diameter: CGFloat {
    return ceil(min(self.width, self.height))
  }
  // Return the inner and outer radii
  func radii(for radius: CGFloat) -> (CGFloat, CGFloat) {
    let diameter = self.diameter
    let innerRadius = max(1, diameter / 2 - radius)
    let outerRadius = diameter / 2
    return (innerRadius, outerRadius)
  }

  var centeredSquare: CGRect {
    let width = ceil(min(size.width, size.height))
    let height = width

    let newOrigin = CGPoint(x: origin.x + (size.width - width) / 2, y: origin.y + (size.height - height) / 2)
    let newSize = CGSize(width: width, height: height)
    return CGRect(origin: newOrigin, size: newSize)
  }
  // swiftlint:disable:next large_tuple
  func flatten() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
    return (origin.x, origin.y, size.width, size.height)
  }
}
