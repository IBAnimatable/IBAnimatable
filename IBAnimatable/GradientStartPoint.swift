//
//  Created by Jake Lin on 12/2/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

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

    let (name, params) = AnimationType.extractNameAndParams(from: string)
    switch name {
    case "top":
      self = .top
    case "topright":
      self = .topRight
    case "right":
      self = .right
    case "bottomright":
      self = .bottomRight
    case "bottom":
      self = .bottom
    case "bottomleft":
      self = .bottomLeft
    case "left":
      self = .left
    case "topleft":
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
