//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class CoverAnimator: NSObject, AnimatedPresenting {

  // MARK: - AnimatedPresenting
  public var transitionDuration: Duration = defaultTransitionDuration

  // MARK: - private
  fileprivate var direction: TransitionAnimationType.Direction

  public init(from direction: TransitionAnimationType.Direction, duration: Duration) {
    self.direction = direction
    self.transitionDuration = duration
    super.init()
  }
}

// MARK: - Animator

extension CoverAnimator: UIViewControllerAnimatedTransitioning {

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

    let finalFrame: CGRect
    if isPresenting {
      finalFrame = getFinalFrame(from: direction, initialFrame: animatingView.frame, containerFrame: containerView.frame)
      containerView.addSubview(animatingView)
    } else {
      // Animate back to origin when dismiss the modal
      let oppositeDirection = direction.opposite
      finalFrame = getFinalFrame(from: oppositeDirection, initialFrame: animatingView.frame, containerFrame: containerView.frame)
    }

    animateCover(animatingView: animatingView, finalFrame: finalFrame) {
      if !isPresenting {
        fromView?.removeFromSuperview()
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

}

// MARK: - Helper

private extension CoverAnimator {

  func getFinalFrame(from direction: TransitionAnimationType.Direction, initialFrame: CGRect, containerFrame: CGRect) -> CGRect {
    var initialFrame = initialFrame
    switch direction {
    case .right:
      initialFrame.origin.x = 0 - initialFrame.size.width
    case .left:
      initialFrame.origin.x = containerFrame.size.width + initialFrame.size.width
    case .top:
      initialFrame.origin.y = containerFrame.size.height + initialFrame.size.height
    case .bottom:
      initialFrame.origin.y = 0 - initialFrame.size.height
    default:
      fatalError("Invalid cover direction")
    }
    return initialFrame
  }

}

// MARK: - Animation

private extension CoverAnimator {

  func animateCover(animatingView: UIView, finalFrame: CGRect, completion: @escaping AnimatableCompletion) {
    UIView.animate(withDuration: transitionDuration, animations: {
      animatingView.frame = finalFrame
    }, completion: { _ in
        completion()
    })
  }

}
