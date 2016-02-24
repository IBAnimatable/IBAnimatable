//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Cube Animator, starts from right
 */
public class CubeFromRightAnimator: NSObject, UIViewControllerAnimatedTransitioning, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType = String(TransitionAnimationType.CubeFromRight)
  public var transitionDuration: Duration = .NaN
  public var reverseAnimationType: String? = String(TransitionAnimationType.CubeFromLeft)

  init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    super.init()
  }

  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return transitionDuration
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: "cube", subtype: kCATransitionFromRight)
  }
}
