//
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

/**
TransitionDirection: used to specify the direction for the transition
*/
public enum TransitionDirection {
  case left
  case right
  case top
  case bottom
  case forward
  case backward
  case `in`
  case out
  case cross
  
  // Convert from direction to CATransition Subtype used in `CATransition`
  var CATransitionSubtype: String {
    switch self {
    case .left:
      return kCATransitionFromLeft
    case .right:
      return kCATransitionFromRight
    case .top:
      // The actual transition direction is oposite, need to reverse
      return kCATransitionFromBottom
    case .bottom:
      // The actual transition direction is oposite, need to reverse
      return kCATransitionFromTop
    default:
      return ""
    }
  }
  
  var isHorizontal: Bool {
    return self == .left || self == .right
  }

  static func fromString(forParams params: [String]) -> TransitionDirection? {
    if params.contains("left") {
      return .left
    } else if params.contains("right") {
      return .right
    } else if params.contains("top") {
      return .top
    } else if params.contains("bottom") {
      return .bottom
    } else if params.contains("forward") {
      return .forward
    } else if params.contains("backward") {
      return .backward
    }
    return nil
  }

  var opposite: TransitionDirection {
    switch self {
    case .left:
      return .right
    case .right:
      return .left
    case .top:
      return .bottom
    case .bottom:
      return .top
    case .in:
      return .out
    case .out:
      return .in
    case .forward:
      return .backward
    case .backward:
      return .forward
    case .cross:
      return .cross
    }
  }
}
