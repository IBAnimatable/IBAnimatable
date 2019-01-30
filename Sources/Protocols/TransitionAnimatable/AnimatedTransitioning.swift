//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
/**
 AnimatedTransitioning is the protocol of all Animator subclasses
 */
public protocol AnimatedTransitioning: ViewControllerAnimatedTransitioning {
  /**
   Transition animation type: used to specify the transition animation.
   */
  var transitionAnimationType: TransitionAnimationType { get set }

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
  func animateWithCATransition(transitionContext: UIViewControllerContextTransitioning,
                               type: TransitionAnimationType.SystemTransitionType,
                               subtype: CATransitionSubtype?) {
    let (_, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
    guard let toView = tempToView, let containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }

    let (_, tempToViewController, _) = retrieveViewControllers(transitionContext: transitionContext)
    if let toViewController = tempToViewController {
      toView.frame = transitionContext.finalFrame(for: toViewController)
    }

    containerView.addSubview(toView)
    CALayer.animate({
      let transition = CATransition()
      #if swift(>=4.2)
      transition.type = CATransitionType(rawValue: type.rawValue)
      #else
      transition.type = type.rawValue
      #endif
      if let subtype = subtype {
        transition.subtype = subtype
      }
      transition.duration = self.transitionDuration(using: transitionContext)
      transition.timingFunctionType = .easeOutCubic
      containerView.layer.add(transition, forKey: kCATransition)
    },
    completion: {
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    })
  }
}
