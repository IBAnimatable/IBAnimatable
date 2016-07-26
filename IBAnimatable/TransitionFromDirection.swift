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
}
