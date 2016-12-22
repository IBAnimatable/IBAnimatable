//
//  Created by Jake Lin on 12/2/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import Foundation
import UIKit

public enum GradientStartPoint: IBEnum {
  case top
  case topRight
  case right
  case bottomRight
  case bottom
  case bottomLeft
  case left
  case topLeft
  case custom(start: CGPoint, end: CGPoint)
  case none
}

extension GradientStartPoint {

  public init(string: String?) {
    guard let string = string else {
      self = .none
      return
    }

    let nameAndParams = AnimationType.extractNameAndParams(from: string)
    let name = nameAndParams.name
    let params = nameAndParams.params
    switch name {
    case "top":
      self = .top
    case "topRight":
      self = .topRight
    case "right":
      self = .right
    case "bottomRight":
      self = .bottomRight
    case "bottom":
      self = .bottom
    case "bottomLeft":
      self = .bottomLeft
    case "left":
      self = .left
    case "topLeft":
      self = .topLeft
    case "custom":
      self = .custom(start: CGPoint(x: params[safe: 0]?.toDouble() ?? 0,
                                    y: params[safe: 1]?.toDouble() ?? 0),
                     end: CGPoint(x: params[safe: 2]?.toDouble() ?? 0,
                                  y: params[safe: 3]?.toDouble() ?? 0))
    default:
      self = .none
    }
  }
}
