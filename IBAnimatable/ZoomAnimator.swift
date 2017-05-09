//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class ZoomAnimator: NSObject, AnimatedPresenting {

  // MARK: - AnimatedPresenting
  public var transitionDuration: Duration = defaultTransitionDuration

  // MARK: - Life cycle
  public init(duration: Duration) {
    transitionDuration = duration
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
    let isPresenting = self.isPresenting(transitionContext: transitionContext)
    guard let containerView = tempContainerView, let animatingView = isPresenting ? toView : fromView else {
      transitionContext.completeTransition(true)
      return
    }

    if isPresenting {
      containerView.addSubview(animatingView)
    }
    animateZoom(animatingView: animatingView, isPresenting: isPresenting) {
      if !isPresenting {
        fromView?.removeFromSuperview()
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

}

// MARK: - Animation

private extension ZoomAnimator {

  func animateZoom(animatingView: UIView, isPresenting: Bool, completion: @escaping AnimatableCompletion) {
    if isPresenting {
      animatePresengingZoom(animatingView: animatingView, completion: completion)
    } else {
      animateDismissingZoom(animatingView: animatingView, completion: completion)
    }
  }

  func animatePresengingZoom(animatingView: UIView, completion: @escaping AnimatableCompletion) {
    animatingView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: transitionDuration,
                   delay: 0.0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0,
                   options: [.curveEaseOut],
    animations: {
      animatingView.transform = CGAffineTransform(scaleX: 1, y: 1)
    }) { _ in
      completion()
    }
  }

  func animateDismissingZoom(animatingView: UIView, completion: @escaping AnimatableCompletion) {
    UIView.animate(withDuration: transitionDuration,
                   delay: 0.0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0,
                   options: [.curveEaseIn],
    animations: {
      animatingView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
      animatingView.alpha = 0.0
    }) { _ in
      completion()
    }
  }

}
