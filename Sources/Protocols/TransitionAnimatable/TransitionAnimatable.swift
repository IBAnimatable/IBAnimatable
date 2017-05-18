//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

/// Protocol for transition animations
public protocol TransitionAnimatable: class {
  /**
   Transition animation type: used to specify the transition animation
   */
  var transitionAnimationType: TransitionAnimationType { get set }

  /**
   Transition duration: default value should be `Double.nan`. Need to use `Double` instead of `TimeInterval` because IB doesn't support `TimeInterval`
   */
  var transitionDuration: Double { get set }

  /**
   Interactive gesture type: used to specify the gesture to dismiss or pop from current scence
   */
  var interactiveGestureType: InteractiveGestureType { get set }
}
