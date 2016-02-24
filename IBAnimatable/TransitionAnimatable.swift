//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public protocol TransitionAnimatable: class {
  /**
   String value of `TransitionAnimationType` enum
   */
  var transitionAnimationType: String? { get set }
  
  /**
   Transition duration: default value should be `Double.NaN`. Need to use `Double` instead of `NSTimeInterval` because IB doesn't support `NSTimeInterval`
   */
  var transitionDuration: Double { get set }
}
