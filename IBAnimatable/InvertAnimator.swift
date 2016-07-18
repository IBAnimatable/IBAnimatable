//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class ZoomAnimator: NSObject, AnimatedPresenting {

  // MARK: - AnimatedPresenting  
  public var transitionDuration: Duration = defaultTransitionDuration

  // MARK: - Life cycle
  public init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    super.init()
  }

}

// MARK: - Animator

extension ZoomAnimator: UIViewControllerAnimatedTransitioning {

  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }

  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let (fromView, toView, tempContainerView) = retrieveViews(transitionContext)
    let presenting = isPresenting(transitionContext)
    guard let containerView = tempContainerView, animatingView = presenting ? toView : fromView else {
      transitionContext.completeTransition(true)
      return
    }

    if presenting {
      containerView.addSubview(animatingView)
    }
    animateZoom(animatingView: animatingView, presenting: presenting) {
      if !presenting {
        fromView?.removeFromSuperview()
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }

}

// MARK: - Animation

private extension ZoomAnimator {

  func animateZoom(animatingView animatingView: UIView, presenting: Bool, completion: AnimatableCompletion) {
    if presenting {
      animatePresengingZoom(animatingView: animatingView, completion: completion)
    } else {
      animateDismissingZoom(animatingView: animatingView, completion: completion)
    }
  }

  func animatePresengingZoom(animatingView animatingView: UIView, completion: AnimatableCompletion) {
    animatingView.transform = CGAffineTransformMakeScale(0.1, 0.1)
    UIView.animateWithDuration(transitionDuration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.CurveEaseOut], animations: {
      animatingView.transform = CGAffineTransformMakeScale(1, 1)
    }) { _ in
      completion()
    }
  }

  func animateDismissingZoom(animatingView animatingView: UIView, completion: AnimatableCompletion) {
    UIView.animateWithDuration(transitionDuration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.CurveEaseIn], animations: {
      animatingView.transform = CGAffineTransformMakeScale(0.1, 0.1)
      animatingView.alpha = 0.0
    }) { _ in
      completion()
    }
  }

}
