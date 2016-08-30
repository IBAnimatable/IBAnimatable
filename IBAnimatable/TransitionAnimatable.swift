//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public protocol TransitionAnimatable: class {
  /**
   String value of `TransitionAnimationType` enum, used to specify the transition animations
   */
  var transitionAnimationType: TransitionAnimationType? { get set }
  
  /**
   Transition duration: default value should be `Double.NaN`. Need to use `Double` instead of `NSTimeInterval` because IB doesn't support `NSTimeInterval`
   */
  var transitionDuration: Double { get set }
  
  /**
   String value of `InteractiveGestureType` enum, used to specify the gesture to dismiss/pop current scence
   */
  var interactiveGestureType: InteractiveGestureType? { get set }
}
