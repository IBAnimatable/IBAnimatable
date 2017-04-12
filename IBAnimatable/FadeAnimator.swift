//
//  Created by Jake Lin on 2/27/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class FadeAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType = .fade(direction: .cross)
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType? = .fade(direction: .cross)
  public var interactiveGestureType: InteractiveGestureType? = .pan(from: .horizontal)

  // MARK: - private
  fileprivate var direction: TransitionAnimationType.Direction

  public init(direction: TransitionAnimationType.Direction, duration: Duration) {
    self.direction = direction
    transitionDuration = duration

    transitionAnimationType = .fade(direction: direction)
    reverseAnimationType = .fade(direction: direction.opposite)

    super.init()
  }
}

extension FadeAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
    guard let fromView = tempfromView, let toView = tempToView, let containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }

    let (_, tempToViewController, _) = retrieveViewControllers(transitionContext: transitionContext)
    if let toViewController = tempToViewController {
      toView.frame = transitionContext.finalFrame(for: toViewController)
    }

    switch direction {
    case .in:
      toView.alpha = 0
      containerView.addSubview(toView)
    case .out:
      containerView.insertSubview(toView, belowSubview: fromView)
    default:
      toView.alpha = 0
      containerView.addSubview(toView)
    }

    UIView.animate(withDuration: transitionDuration(using: transitionContext),
      animations: {
        switch self.direction {
        case .in:
          toView.alpha = 1
        case .out:
          fromView.alpha = 0
        default:
          fromView.alpha = 0
          toView.alpha = 1
        }
      },
      completion: { _ in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    )
  }
}
