//
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
TransitionFromDirection: convert from direction to CATransition Subtype used in `CATransition`
*/
public enum TransitionFromDirection {
  case Left
  case Right
  case Top
  case Bottom
  
  var stringValue: String {
    switch self {
    case .Left:
      return kCATransitionFromLeft
    case .Right:
      return kCATransitionFromRight
    case .Top:
      return kCATransitionFromTop
    case .Bottom:
      return kCATransitionFromBottom
    }
  }
}
