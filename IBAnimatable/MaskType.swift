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
  
  public enum WaveDirection: String {
    case up
    case down
  }
}

public extension MaskType  {
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
      self = .polygon(sides: nil)
    case "star":
      self = .star(points: Int(params[0]))
    case "triangle":
      self = .triangle
    case "wave":
      self = .wave(direction: WaveDirection(rawValue:params[0].lowercased()), width: Float(params[1]), offset:Float(params[2]))
    case "parallelogram":
      self = .parallelogram(angle: Double(params[0]))
    default:
      self = .none
    }
  }
}
