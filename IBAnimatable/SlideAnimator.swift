//
//  Created by Tom Baranes on 08/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class SlideAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?

  // MARK: - private
  fileprivate var fromDirection: TransitionAnimationType.Direction
  fileprivate var isHorizontal = false
  fileprivate var isReverse = false
  fileprivate var isFade = false

  public init(from direction: TransitionAnimationType.Direction, isFade: Bool, duration: Duration) {
    fromDirection = direction
    transitionDuration = duration
    self.isFade = isFade
    isHorizontal = fromDirection.isHorizontal
    transitionAnimationType = .slide(to: direction, isFade: isFade)
    reverseAnimationType = .slide(to: direction.opposite, isFade: isFade)
    interactiveGestureType = .pan(from: direction.matchingGesture)
    isReverse = direction == .right || direction == .bottom

    super.init()
  }
}

extension SlideAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
    guard let fromView = tempfromView, let toView = tempToView, let containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }

    let travelDistance = isHorizontal ? containerView.bounds.width : containerView.bounds.height
    let travel = CGAffineTransform(translationX: isHorizontal ? (isReverse ? travelDistance : -travelDistance) : 0,
                                   y: isHorizontal ? 0 : (isReverse ? travelDistance : -travelDistance))
    containerView.addSubview(toView)
    if isFade {
      toView.alpha = 0
    }
    toView.transform = travel.inverted()
    animateSlideTransition(toView: toView, fromView: fromView, travel: travel) {
      toView.transform = CGAffineTransform.identity
      fromView.transform = CGAffineTransform.identity
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }
}

// MARK: - Animation

private extension SlideAnimator {
  func animateSlideTransition(toView: UIView, fromView: UIView, travel: CGAffineTransform, completion: @escaping AnimatableCompletion) {
    UIView.animate(withDuration: transitionDuration, animations: {
      fromView.transform = travel
      toView.transform = CGAffineTransform.identity
      if self.isFade {
        fromView.alpha = 0
        toView.alpha = 1
      }
    },
    completion: { _ in
      completion()
    })
  }
}
