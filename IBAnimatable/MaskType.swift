//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation
import UIKit

public enum MaskType: IBEnum {
  case circle
  case polygon(sides:Int?)
  case star(points:Int?)
  case triangle
  case wave(direction:WaveDirection?, width:Float?, offset:Float?)
  case parallelogram(angle:Double?)
  case none
  
  public enum WaveDirection:String {
    case up
    case down
  }
}


public extension MaskType  {
  init(string:String) {
    let paramsAndName = MaskType.extractNameAndParams(string)
    let name = paramsAndName.name;
    let params = paramsAndName.params;
    
    switch name.lowercased() {
    case "circle":
      self = MaskType.circle
    case "polygon":
      self = MaskType.polygon(sides: nil)
    case "star":
      self = MaskType.star(points: Int(params[0]))
    case "triangle":
      self = MaskType.triangle;
    case "wave":
      self = MaskType.wave(direction: WaveDirection(rawValue:params[0].lowercased()), width: Float(params[1]), offset:Float(params[2]))
    case "parallelogram":
      self = MaskType.parallelogram(angle: Double(params[0]))
    default:
      self = MaskType.none
    }
  }
}
