//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
/**
 AnimatedTransitioning is the protocol of all Animator subclasses
 */
public protocol AnimatedTransitioning: UIViewControllerAnimatedTransitioning {
  
  /**
   String value of `TransitionAnimationType` enum
   */
  var transitionAnimationType: String { get set }
  
  /**
   Transition duration
   */
  var transitionDuration: Duration { get set }

  /**
   Reverse animation type: used to specify the revers animation for pop or dismiss.
   */
  var reverseAnimationType: String? { get set }
}

public extension AnimatedTransitioning {
  public func retrieveViews(transitionContext: UIViewControllerContextTransitioning) -> (UIView?, UIView?, UIView?) {
    return (transitionContext.viewForKey(UITransitionContextFromViewKey), transitionContext.viewForKey(UITransitionContextToViewKey), transitionContext.containerView())
  }

  public func animateWithCATransition(transitionContext: UIViewControllerContextTransitioning, type: String, subtype: String?) {
    let (_, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }

    containerView.addSubview(toView)
    CALayer.animate({
      let transition = CATransition()
      transition.type = type
      if let subtype = subtype {
        transition.subtype = subtype
      }
      transition.duration = self.transitionDuration(transitionContext)

      containerView.layer.addAnimation(transition, forKey: kCATransition)
    }) {
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
}
