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

  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let (fromView, toView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
    let presenting = isPresenting(transitionContext: transitionContext)
    guard let containerView = tempContainerView, let animatingView = presenting ? toView : fromView else {
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
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

}

// MARK: - Animation

private extension ZoomAnimator {

  func animateZoom(animatingView: UIView, presenting: Bool, completion: AnimatableCompletion) {
    if presenting {
      animatePresengingZoom(animatingView: animatingView, completion: completion)
    } else {
      animateDismissingZoom(animatingView: animatingView, completion: completion)
    }
  }

  func animatePresengingZoom(animatingView: UIView, completion: AnimatableCompletion) {
    animatingView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: transitionDuration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
      animatingView.transform = CGAffineTransform(scaleX: 1, y: 1)
    }) { _ in
      completion()
    }
  }

  func animateDismissingZoom(animatingView: UIView, completion: AnimatableCompletion) {
    UIView.animate(withDuration: transitionDuration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
      animatingView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
      animatingView.alpha = 0.0
    }) { _ in
      completion()
    }
  }

}
