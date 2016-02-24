//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
/**
 AnimatedTransitioning is the protocol of all Animator subclasses
 */
protocol AnimatedTransitioning: UIViewControllerAnimatedTransitioning {
  
  /**
   String value of `TransitionAnimationType` enum
   */
  var transitionAnimationType: String { get set }
  
  /**
   Transition duration
   */
  var transitionDuration: Duration { get set }
}
