//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public typealias FrameTransformer = (finalFrame: CGRect, containerFrame: CGRect) -> CGRect

public protocol AnimatedPresenting: UIViewControllerAnimatedTransitioning {

  var transitionAnimationType: PresentationAnimationType { get set }
  var transitionDuration: Duration { get set }

  func retrieveTransitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
  func animate(transitionContext: UIViewControllerContextTransitioning, transform: FrameTransformer)
}

public extension AnimatedPresenting {

  public func retrieveTransitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    if let transitionContext = transitionContext {
      return transitionContext.isAnimated() ? transitionDuration : 0
    }
    return 0
  }

  func animate(transitionContext: UIViewControllerContextTransitioning, transform: FrameTransformer) {
    guard let containerView = transitionContext.containerView() else {
      return
    }

    let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
    let isPresenting: Bool = (toViewController?.presentingViewController == fromViewController)
    let animatingVC = isPresenting ? toViewController : fromViewController
    let animatingView = isPresenting ? toView : fromView
    let finalFrameForVC = transitionContext.finalFrameForViewController(animatingVC!)
    let initialFrameForVC = transform(finalFrame: finalFrameForVC, containerFrame: containerView.frame)
    let initialFrame = isPresenting ? initialFrameForVC : finalFrameForVC
    let finalFrame = isPresenting ? finalFrameForVC : initialFrameForVC
    let duration = transitionDuration(transitionContext)
    if isPresenting {
      containerView.addSubview(toView!)
    }

    animatingView?.frame = initialFrame
    UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 300.0, initialSpringVelocity: 5.0, options: .AllowUserInteraction, animations: {
      animatingView?.frame = finalFrame
    }, completion: { value in
        if !isPresenting {
          fromView?.removeFromSuperview()
        }
        let wasCancelled = transitionContext.transitionWasCancelled()
        transitionContext.completeTransition(!wasCancelled)
    })
  }

}
