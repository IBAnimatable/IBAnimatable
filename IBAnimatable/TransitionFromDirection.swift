//
//  Copyright © 2016 Jake Lin. All rights reserved.
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
}
