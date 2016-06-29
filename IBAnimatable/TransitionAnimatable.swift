//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public protocol TransitionAnimatable: class {
  /**
   String value of `TransitionAnimationType` enum, used to specify the transition animations
   */
  var transitionAnimationType: String? { get set }
  
  /**
   Transition duration: default value should be `Double.NaN`. Need to use `Double` instead of `NSTimeInterval` because IB doesn't support `NSTimeInterval`
   */
  var transitionDuration: Double { get set }
  
  /**
   String value of `InteractiveTransitionType` enum, used to specify the gesture to dismiss/pop current scence
   */
  var interactiveGestureType: String? { get set }
}
