//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class CoverAnimator: NSObject, AnimatedPresenting {

  // MARK: - AnimatedPresenting  
  public var transitionDuration: Duration = defaultTransitionDuration

  // MARK: - private
  private var direction: TransitionDirection

  public init(from direction: TransitionDirection, transitionDuration: Duration) {
    self.direction = direction
    self.transitionDuration = transitionDuration
    super.init()
  }
}

// MARK: - Animator

extension CoverAnimator: UIViewControllerAnimatedTransitioning {

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

    let finalFrame: CGRect
    if presenting {
      finalFrame = getFinalFrame(from: direction, initialFrame: animatingView.frame, containerFrame: containerView.frame)
      containerView.addSubview(animatingView)
    } else {
      // Animate back to origin when dismiss the modal
      let oppositeDirection = direction.opposite
      finalFrame = getFinalFrame(from: oppositeDirection, initialFrame: animatingView.frame, containerFrame: containerView.frame)
    }
    
    animateCover(animatingView: animatingView, finalFrame: finalFrame) {
      if !presenting {
        fromView?.removeFromSuperview()
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }

}

// MARK: - Helper

private extension CoverAnimator {

  func getFinalFrame(from direction: TransitionDirection, initialFrame: CGRect, containerFrame: CGRect) -> CGRect {
    var initialFrame = initialFrame
    switch direction {
    case .Right:
      initialFrame.origin.x = 0 - initialFrame.size.width
    case .Left:
      initialFrame.origin.x = containerFrame.size.width + initialFrame.size.width
    case .Top:
      initialFrame.origin.y = containerFrame.size.height + initialFrame.size.height
    case .Bottom:
      initialFrame.origin.y = 0 - initialFrame.size.height
    default:
      fatalError()
    }
    return initialFrame
  }

}

// MARK: - Animation

private extension CoverAnimator {

  func animateCover(animatingView animatingView: UIView, finalFrame: CGRect, completion: AnimatableCompletion) {
    UIView.animateWithDuration(transitionDuration, animations: {
      animatingView.frame = finalFrame
    }, completion: { _ in
        completion()
    })
  }

}
