//
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

/**
TransitionDirection: used to specify the direction for the transition
*/
public enum TransitionDirection {
  case Left
  case Right
  case Top
  case Bottom
  case Forward
  case Backward
  case In
  case Out
  case Cross
  
  // Convert from direction to CATransition Subtype used in `CATransition`
  var CATransitionSubtype: String {
    switch self {
    case .Left:
      return kCATransitionFromLeft
    case .Right:
      return kCATransitionFromRight
    case .Top:
      // The actual transition direction is oposite, need to reverse
      return kCATransitionFromBottom
    case .Bottom:
      // The actual transition direction is oposite, need to reverse
      return kCATransitionFromTop
    default:
      return ""
    }
  }
  
  var isHorizontal: Bool {
    return self == .Left || self == .Right
  }

  static func fromString(forParams params: [String]) -> TransitionDirection? {
    if params.contains("left") {
      return .Left
    } else if params.contains("right") {
      return .Right
    } else if params.contains("top") {
      return .Top
    } else if params.contains("bottom") {
      return .Bottom
    } else if params.contains("forward") {
      return .Forward
    } else if params.contains("backward") {
      return .Backward
    }
    return nil
  }

  var opposite: TransitionDirection {
    switch self {
    case .Left:
      return .Right
    case .Right:
      return .Left
    case .Top:
      return .Bottom
    case .Bottom:
      return .Top
    case .In:
      return .Out
    case .Out:
      return .In
    case .Forward:
      return .Backward
    case .Backward:
      return .Forward
    case .Cross:
      return .Cross
    }
  }
}
