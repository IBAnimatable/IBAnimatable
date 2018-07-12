//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public typealias CustomMaskProvider = (CGSize) -> UIBezierPath

/**
 Mask type for masking an IBAnimatable UI element.
*/

public enum MaskType: IBEnum {
  /// For circle shape with diameter equals to min(width, height).
  case circle
  /// For ellipse shape.
  case ellipse
  /// For polygon shape with `n` sides. (min: 3, the default: 6).
  case polygon(sides: Int)
  /// For star shape with n points (min: 3, default: 5)
  case star(points: Int)
  /// For isosceles triangle shape. The triangle's height is equal to the view's frame height. If the view is a square, the triangle is equilateral.
  case triangle
  /// For wave shape with `direction` (up or down, default: up), width (default: 40) and offset (default: 0)
  case wave(direction: WaveDirection, width: Double, offset: Double)
  ///  For parallelogram shape with an angle (default: 60). If `angle == 90` then it is a rectangular mask. If `angle < 90` then is a left-oriented parallelogram\-\
  case parallelogram(angle: Double)
  /// For heart shape.
  case heart
  /// For ring shape with radius (min: 1). 
  case ring(radius: Double)
  /// For gear shape with radius (min: 1) and cogs count (min: 2).
  case gear(radius: Double, cogs: Int)
  /// For super ellipse shape.
  case superEllipse(n: Double)
  /// For drop shape.
  case drop
  /// For plus sign shape
  case plusSign(width: Double)
  /// For moon shape
  case moon(angle: Double)
  /// For a smaller rectangle than the source rectangle, with the same center point.
  case insetBy(dx: Double, dy: Double)
  /// For a rounded rectangle.
  case rounded(radii: (Double, Double), cornerSides: CornerSides)

  /// Custom shape
  case custom(pathProvider: CustomMaskProvider)

  case none

  /**
   Wave direction for `wave` shape.
   */
  public enum WaveDirection: String {
    /// For the wave facing up.
    case up
    /// For the wave facing down.
    case down
  }
}

#if swift(>=4.2)
extension MaskType.WaveDirection: CaseIterable {}
#endif

public extension MaskType {
  init(string: String?) {
    guard let string = string else {
      self = .none
      return
    }

    let (name, params) = MaskType.extractNameAndParams(from: string)

    switch name {
    case "circle":
      self = .circle
    case "ellipse":
      self = .ellipse
    case "polygon":
      self = .polygon(sides: params[safe: 0]?.toInt() ?? 6)
    case "star":
      self = .star(points: params[safe: 0]?.toInt() ?? 5)
    case "triangle":
      self = .triangle
    case "wave":
      self = .wave(direction: WaveDirection(raw: params[safe: 0], defaultValue: .up),
                   width: params[safe: 1]?.toDouble() ?? 40,
                   offset: params[safe: 2]?.toDouble() ?? 0)
    case "parallelogram":
      self = .parallelogram(angle: params[safe: 0]?.toDouble() ?? 60)
    case "heart":
      self = .heart
    case "ring":
      self = .ring(radius: params[safe: 0]?.toDouble() ?? 10 )
    case "gear":
      self = .gear(radius: params[safe: 0]?.toDouble() ?? 10, cogs: params[safe: 1]?.toInt() ?? 6 )
    case "superellipse":
      self = .superEllipse(n: params[safe: 0]?.toDouble() ?? M_E )
    case "drop":
      self = .drop
    case "plussign":
      self = .plusSign(width: params[safe: 0]?.toDouble() ?? 10 )
    case "moon":
      self = .moon(angle: params[safe: 0]?.toDouble() ?? 60 )
    case "insetby":
      let x = params[safe: 0]?.toDouble() ?? 0
      self = .insetBy(dx: x, dy: params[safe: 1]?.toDouble() ?? x )
    case "rounded":
      let radii = params.compactMap { $0.toDouble() }
      let radius: Double = radii[safe: 0] ?? 0
      let corners = params.compactMap { CornerSide(rawValue: $0).map { CornerSides(side: $0) } }
      var cornerSides = CornerSides(corners)
      if cornerSides == .unknown {
        cornerSides = .allSides
      }
      self = .rounded(radii: (radius, radii[safe: 1] ?? radius), cornerSides: cornerSides)
    default:
      self = .none
    }
  }
}

// MARK: UIKit

extension MaskType {

  func bezierPath(in rect: CGRect) -> UIBezierPath {
    switch self {
    case .circle:
      return UIBezierPath(circleIn: rect)
    case .ellipse:
      return UIBezierPath(ovalIn: rect)
    case let .parallelogram(angle):
      return UIBezierPath(parallelogramIn: rect, with: angle)
    case let .polygon(sides):
      return UIBezierPath(polygonIn: rect, with: sides)
    case let .star(points):
      return UIBezierPath(starIn: rect, with: points)
    case let .wave(direction, width, offset):
      return UIBezierPath(waveIn: rect, with: direction == .up, width: CGFloat(width), offset: CGFloat(offset))
    case .triangle:
      return UIBezierPath(triangleIn: rect)
    case .heart:
      return UIBezierPath(heartIn: rect)
    case .ring(let radius):
      return UIBezierPath(ringIn: rect, radius: CGFloat(radius))
    case .gear(let radius, let cogs):
      return UIBezierPath(gearIn: rect, radius: CGFloat(radius), cogs: cogs)
    case .superEllipse(let n):
      return UIBezierPath(superEllipseInRect: rect, n: CGFloat(n))
    case .drop:
      return UIBezierPath(dropInRect: rect)
    case .plusSign(let width):
      return UIBezierPath(plusSignInRect: rect, width: CGFloat(width))
    case .moon(let angle):
      return UIBezierPath(moonInRect: rect, with: CGFloat(angle))
    case .insetBy(let dx, let dy):
      return UIBezierPath(rect: rect.insetBy(dx: CGFloat(dx), dy: CGFloat(dy)))
    case .rounded(let radii, let cornerSides):
      return UIBezierPath(roundedRect: rect, byRoundingCorners: cornerSides.rectCorner, cornerRadii: CGSize(width: radii.0, height: radii.1))
    case let .custom(pathProvider):
      return pathProvider(rect.size)
    case .none:
      return UIBezierPath()
    }
  }

}

extension CornerSides {

  var rectCorner: UIRectCorner {
    if self == .allSides {
      return .allCorners
    }
    var corners: UIRectCorner = []
    if self.contains(.topLeft) {
      corners.insert(.topLeft)
    }
    if self.contains(.topRight) {
      corners.insert(.topRight)
    }
    if self.contains(.bottomLeft) {
      corners.insert(.bottomLeft)
    }
    if self.contains(.bottomRight) {
      corners.insert(.bottomRight)
    }
    return corners
  }

}
