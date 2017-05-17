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
    default:
      self = .none
    }
  }
}
