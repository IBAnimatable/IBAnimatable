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
    guard let (name, params) = string.extractNameAndParams() else {
      self = .none
      return
    }
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
      self = .custom(start: CGPoint(x: params.toDouble(0) ?? 0,
                                    y: params.toDouble(1) ?? 0),
                     end: CGPoint(x: params.toDouble(2) ?? 0,
                                  y: params.toDouble(3) ?? 0))
    default:
      self = .none
    }
  }
}

extension GradientStartPoint {

  var startPoint: CGPoint {
    switch self {
    case .top:
      return CGPoint(x: 0.5, y: 0)
    case .topRight:
      return CGPoint(x: 1, y: 0)
    case .right:
      return CGPoint(x: 1, y: 0.5)
    case .bottomRight:
      return CGPoint(x: 1, y: 1)
    case .bottom:
      return CGPoint(x: 0.5, y: 1)
    case .bottomLeft:
      return CGPoint(x: 0, y: 1)
    case .left:
      return CGPoint(x: 0, y: 0.5)
    case .topLeft:
      return CGPoint(x: 0, y: 0)
    case let .custom(start, _):
      return start
    case .none:
      return .zero
    }
  }

  var endPoint: CGPoint {
    switch self {
    case .top:
      return CGPoint(x: 0.5, y: 1)
    case .topRight:
      return CGPoint(x: 0, y: 1)
    case .right:
      return CGPoint(x: 0, y: 0.5)
    case .bottomRight:
      return CGPoint(x: 0, y: 0)
    case .bottom:
      return CGPoint(x: 0.5, y: 0)
    case .bottomLeft:
      return  CGPoint(x: 1, y: 0)
    case .left:
      return CGPoint(x: 1, y: 0.5)
    case .topLeft:
      return CGPoint(x: 1, y: 1)
    case let .custom(_, end):
      return end
    case .none:
      return .zero
    }
  }

  var points: (CGPoint, CGPoint) {
    return (startPoint, endPoint)
  }
}
