//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation
import UIKit

/// Add a masking shape.
public enum MaskType: IBEnum {
  
  /// Circle shape with diameter equals to min(width, height)
  case circle
  
  ///  Polygon shape with n sides. (min 3, default)
  case polygon(sides:Int?)
  /// Star shape with n points (min 3, default:6)
  
  case star(points:Int?)
  /// Isocele triangle shape. The triangle's height is equal to the view's frame height. If the view is a square, Triangle is equilateral.
  case triangle
  
  /// Wave shape, with
  /// direction (up or down, default : up)
  /// width (default 40)
  /// offset (default : 0)
  case wave(direction:WaveDirection?, width:Float?, offset:Float?)
  
  /// Parallelogram Mask with angle (defalut : 60) 
  /// If angle == 90 => Rectangular Mask
  /// If angle < 90 => left oriented parallelogram \-\
  case parallelogram(angle:Double?)
  /// No mask.
  case none
  
  public enum WaveDirection: String {
    case up
    case down
  }
}

public extension MaskType {
  init(string: String?) {
    // If the string is nil, return `.none`
    guard let string = string else {
      self = .none
      return
    }
    
    let paramsAndName = MaskType.extractNameAndParams(from: string)
    let name = paramsAndName.name
    let params = paramsAndName.params
    
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
