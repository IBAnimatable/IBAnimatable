//
//  Created by Jake Lin on 2/20/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Cube Animator, starts from top
 */
public class CubeFromBottomAnimator: NSObject, UIViewControllerAnimatedTransitioning, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType = String(TransitionAnimationType.CubeFromBottom)
  public var transitionDuration: Duration = .NaN
  public var reverseAnimationType: String? = String(TransitionAnimationType.CubeFromTop)

  init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    super.init()
  }
  
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return transitionDuration
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: CATransitionType.cube, subtype: kCATransitionFromBottom)
  }
}
