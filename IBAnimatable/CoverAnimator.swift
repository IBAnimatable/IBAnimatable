//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class CoverAnimator: NSObject, AnimatedPresenting {

  // MARK: - AnimatedPresenting
  public var transitionAnimationType: PresentationAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration

  // MARK: - private
  private var direction: TransitionDirection

  public init(direction: TransitionDirection, transitionDuration: Duration) {
    self.direction = direction
    self.transitionDuration = transitionDuration

    switch direction {
    case .Left:
      self.transitionAnimationType = .Cover(fromDirection: .Left)
    case .Right:
      self.transitionAnimationType = .Cover(fromDirection: .Right)
    case .Top:
      self.transitionAnimationType = .Cover(fromDirection: .Top)
    default:
      self.transitionAnimationType = .Cover(fromDirection: .Bottom)
    }
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

    let newFrame = finalFrame(from: animatingView.frame, containerFrame: containerView.frame)
    if presenting {
      containerView.addSubview(animatingView)
    }
    animateCover(animatingView: animatingView, finalFrame: newFrame) {
      if !presenting {
        fromView?.removeFromSuperview()
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }

}

// MARK: - Helper

private extension CoverAnimator {

  func finalFrame(from initialFrame: CGRect, containerFrame: CGRect) -> CGRect {
    var initialFrame = initialFrame
    switch self.direction {
    case .Right:
      initialFrame.origin.x = containerFrame.size.width + initialFrame.size.width
    case .Left:
      initialFrame.origin.x = 0 - initialFrame.size.width
    default: // .Top, .Bottom is handled by the system animation
      initialFrame.origin.y = 0 - initialFrame.size.height
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
