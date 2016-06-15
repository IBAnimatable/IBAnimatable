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
   Value of `TransitionAnimationType` enum
   */
  var transitionAnimationType: TransitionAnimationType { get set }
  
  /**
   Transition duration
   */
  var transitionDuration: Duration { get set }

  /**
   Reverse animation type: used to specify the revers animation for pop or dismiss.
   */
  var reverseAnimationType: TransitionAnimationType? { get set }
  
  /**
   Interactive gesture type: used to specify the gesture type to pop or dismiss.
   */
  var interactiveGestureType: InteractiveGestureType? { get set }
}

public extension AnimatedTransitioning {
  public func retrieveViews(_ transitionContext: UIViewControllerContextTransitioning) -> (UIView?, UIView?, UIView?) {
    return (transitionContext.view(forKey: UITransitionContextFromViewKey), transitionContext.view(forKey: UITransitionContextToViewKey), transitionContext.containerView())
  }
  
  public func retrieveViewControllers(_ transitionContext: UIViewControllerContextTransitioning) -> (UIViewController?, UIViewController?, UIView?) {
    return (transitionContext.viewController(forKey: UITransitionContextFromViewControllerKey), transitionContext.viewController(forKey: UITransitionContextToViewControllerKey), transitionContext.containerView())
  }
  
  public func retrieveTransitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    if let transitionContext = transitionContext {
      return transitionContext.isAnimated() ? transitionDuration : 0
    }
    return 0
  }
  
  public func animateWithCATransition(_ transitionContext: UIViewControllerContextTransitioning, type: SystemTransitionType, subtype: String?) {
    let (_, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }

    containerView.addSubview(toView)
    CALayer.animate({
      let transition = CATransition()
      transition.type = type.rawValue
      if let subtype = subtype {
        transition.subtype = subtype
      }
      transition.duration = self.transitionDuration(transitionContext)
      // Use `EaseOutQubic` for system built-in transition animations. Thanks to @lexrus
      transition.timingFunction = CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
      containerView.layer.add(transition, forKey: kCATransition)
    },
    completion: {
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    })
  }
}
