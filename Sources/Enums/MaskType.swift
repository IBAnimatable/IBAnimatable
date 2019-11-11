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
  /// For rounded polygon shape with `n` sides. (min: 3, the default: 6).
  case roundedPolygon(sides: Int, cornerRadius: Double)
  /// For kite shape.
  case kite(angle: Double)

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

    guard let (name, params) = string.extractNameAndParams() else {
      self = .none
      return
    }
    switch name {
    case "circle":
      self = .circle
    case "ellipse":
      self = .ellipse
    case "polygon":
      self = .polygon(sides: params.toInt(0) ?? 6)
    case "roundedpolygon":
      self = .roundedPolygon(sides: params.toInt(0) ?? 6, cornerRadius: params.toDouble(1) ?? 10)
    case "star":
      self = .star(points: params.toInt(0) ?? 5)
    case "triangle":
      self = .triangle
    case "wave":
      self = .wave(direction: WaveDirection(raw: params.toString(0), defaultValue: .up),
                   width: params.toDouble(1) ?? 40,
                   offset: params.toDouble(2) ?? 0)
    case "parallelogram":
      self = .parallelogram(angle: params.toDouble(0) ?? 60)
    case "heart":
      self = .heart
    case "ring":
      self = .ring(radius: params.toDouble(0) ?? 10 )
    case "gear":
      self = .gear(radius: params.toDouble(0) ?? 10, cogs: params.toInt(1) ?? 6 )
    case "superellipse":
      self = .superEllipse(n: params.toDouble(0) ?? M_E )
    case "drop":
      self = .drop
    case "plussign":
      self = .plusSign(width: params.toDouble(0) ?? 10 )
    case "moon":
      self = .moon(angle: params.toDouble(0) ?? 60 )
    case "insetby":
      let x = params.toDouble(0) ?? 0
      self = .insetBy(dx: x, dy: params.toDouble(1) ?? x )
    case "rounded":
      let radii = params.toDoubles()
      let radius: Double = radii[safe: 0] ?? 0
      let corners = params.compactMap { CornerSide(rawValue: $0.name).map { CornerSides(side: $0) } }
      var cornerSides = CornerSides(corners)
      if cornerSides == .unknown {
        cornerSides = .allSides
      }
      self = .rounded(radii: (radius, radii[safe: 1] ?? radius), cornerSides: cornerSides)
    case "kite":
      self = .kite(angle: params.toDouble(0) ?? 74)
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
    case .roundedPolygon(let sides, let cornerRadius):
      return UIBezierPath(roundedPolygonInRect: rect, with: sides, cornerRadius: CGFloat(cornerRadius))
    case .kite(let angle):
      return UIBezierPath(kiteInRect: rect, with: CGFloat(angle))
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
