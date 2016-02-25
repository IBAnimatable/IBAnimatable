//
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
TransitionFromDirection: convert from direction to CATransition Subtype used in `CATransition`
*/
public enum TransitionFromDirection {
  case FromLeft
  case FromRight
  case FromTop
  case FromBottom
  
  var stringValue: String {
    switch self {
    case .FromLeft:
      return kCATransitionFromLeft
    case .FromRight:
      return kCATransitionFromRight
    case .FromTop:
      return kCATransitionFromTop
    case .FromBottom:
      return kCATransitionFromBottom
    }
  }
  
  var animationType: TransitionAnimationType {
    switch self {
    case .FromLeft:
      return .CubeFromLeft
    case .FromRight:
      return .CubeFromRight
    case .FromTop:
      return .CubeFromTop
    case .FromBottom:
      return .CubeFromBottom
    }
  }
  
  var reverseAnimationType: TransitionAnimationType {
    switch self {
    case .FromLeft:
      return .CubeFromRight
    case .FromRight:
      return .CubeFromLeft
    case .FromTop:
      return .CubeFromBottom
    case .FromBottom:
      return .CubeFromTop
    }
  }
}
