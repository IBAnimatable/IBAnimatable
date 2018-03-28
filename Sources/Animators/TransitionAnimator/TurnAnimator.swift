//
//  Created by Tom Baranes on 01/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class TurnAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType? = .pan(from: .horizontal)

  // MARK: - Private params
  fileprivate var fromDirection: TransitionAnimationType.Direction

  // MARK: - Private fold transition
  fileprivate var transform: CATransform3D = CATransform3DIdentity
  fileprivate var reverse: Bool = false

  // MARK: - Life cycle
  public init(from direction: TransitionAnimationType.Direction, duration: Duration) {
    fromDirection = direction
    transitionDuration = duration
    transitionAnimationType = .turn(from: direction)
    reverseAnimationType = .turn(from: direction.opposite)
    interactiveGestureType = .pan(from: direction.opposingGesture)
    reverse = direction == .right || direction == .bottom

    super.init()
  }
}

extension TurnAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
    guard let fromView = tempfromView, let toView = tempToView, let containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }

    containerView.addSubview(toView)
    transform.m34 = -0.002
    containerView.layer.sublayerTransform = transform
    toView.frame = fromView.frame
    animateTurnTransition(fromView: fromView, toView: toView) {
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

  private func animateTurnTransition(fromView: UIView, toView: UIView, completion: @escaping AnimatableCompletion) {
    let factor = reverse ? 1.0 : -1.0
    toView.layer.transform = rotate(angle: factor * -.pi / 2)
    UIView.animateKeyframes(withDuration: transitionDuration, delay: 0.0, options: .layoutSubviews, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
            fromView.layer.transform = self.rotate(angle: factor * .pi / 2)
      }

      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
        toView.layer.transform = self.rotate(angle: 0.0)
      }
    }) { _ in
      completion()
    }
  }

}

// MARK: - Helpers

private extension TurnAnimator {

  func rotate(angle: Double) -> CATransform3D {
    if fromDirection == .left || fromDirection == .right {
      return  CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    } else {
      return  CATransform3DMakeRotation(CGFloat(angle), 1.0, 0.0, 0.0)
    }
  }

}
