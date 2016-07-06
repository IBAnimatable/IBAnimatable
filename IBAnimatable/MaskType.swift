//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation
import UIKit

/**
 Mask type for masking an IBAnimatable UI element.
 
 - circle: For circle shape with diameter equals to min(width, height).
 - polygon: For polygon shape with `n` sides. (min: 3, the default: 6).
 - star: For star shape with n points (min: 3, default:6)
 - triangle: For isosceles triangle shape. The triangle's height is equal to the view's frame height. If the view is a square, the triangle is equilateral.
 - wave: For wave shape with `direction` (up or down, default: up), width (default: 40) and offset (default: 0)
 - parallelogram: For parallelogram shape with an angle (default: 60). If `angle == 90` then it is a rectangular mask. If `angle < 90` then is a left-oriented parallelogram \\-\\
 - none: For no mask, if the input `string` of `init` is nil, the value of the neum is `.none`. If the `string` can not be mapped to supported mask type, it will set to default value `.none`.
 */

public enum MaskType: IBEnum {
  case circle
  case polygon(sides:Int?)
  case star(points:Int?)
  case triangle
  case wave(direction:WaveDirection?, width:Float?, offset:Float?)
  case parallelogram(angle:Double?)
  case none
  
  /**
   Wave direction for `wave` shape.
   
   - up: For the wave facing up.
   - down: For the wave facing down.
   */
  public enum WaveDirection: String {
    case up
    case down
  }
}

public extension MaskType {
  init(string: String?) {
    guard let string = string else {
      self = .none
      return
    }
    
    let nameAndParames = MaskType.extractNameAndParams(from: string)
    let name = nameAndParames.name
    let params = nameAndParames.params
    
    switch name.lowercased() {
    case "circle":
      self = .circle
    case "polygon":
      self = .polygon(sides: Int(params[safe:0] ?? ""))
    case "star":
      self = .star(points: Int(params[safe:0] ?? ""))
    case "triangle":
      self = .triangle
    case "wave":
      self = .wave(direction: WaveDirection(rawValue:(params[safe:0] ?? "").lowercased()), width: Float(params[safe:1] ?? ""), offset:Float(params[safe:2] ?? ""))
    case "parallelogram":
      self = .parallelogram(angle: Double(params[safe:0] ?? ""))
    default:
      self = .none
    }
  }
}
