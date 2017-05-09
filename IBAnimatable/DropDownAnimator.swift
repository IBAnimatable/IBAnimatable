//
//  Created by Tom Baranes on 13/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class DropDownAnimator: NSObject, AnimatedPresenting {

  // MARK: - AnimatedPresenting
  public var transitionDuration: Duration = defaultTransitionDuration
  fileprivate var completion: AnimatableCompletion?

  // MARK: - Life cycle
  public init(duration: Duration) {
    transitionDuration = duration
    super.init()
  }

}

// MARK: - Animator

extension DropDownAnimator: UIViewControllerAnimatedTransitioning {

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
    animateDropDown(animatingView: animatingView, isPresenting: isPresenting) {
      if !isPresenting {
        fromView?.removeFromSuperview()
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

}

// MARK: - Animation

private extension DropDownAnimator {

  func animateDropDown(animatingView: UIView, isPresenting: Bool, completion: @escaping AnimatableCompletion) {
    if isPresenting {
      animatePresengingDropDown(animatingView: animatingView, completion: completion)
    } else {
      animateDismissingDropDown(animatingView: animatingView, completion: completion)
    }
  }

  func animatePresengingDropDown(animatingView: UIView, completion: @escaping AnimatableCompletion) {
    let y = animatingView.center.y
    let animation = CAKeyframeAnimation(keyPath: "position.y")
    animation.values = [y - UIScreen.main.bounds.height, y + 20, y - 10, y]
    animation.keyTimes = [0, 0.5, 0.75, 1]
    animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
                                 CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
                                 CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
    animation.duration = transitionDuration
    animation.delegate = self
    self.completion = completion
    animatingView.layer.add(animation, forKey: "dropdown")
  }

  func animateDismissingDropDown(animatingView: UIView, completion: @escaping AnimatableCompletion) {
    var point = animatingView.center
    let angle = CGFloat(arc4random_uniform(100)) - 50
    point.y += UIScreen.main.bounds.height
    UIView.animate(withDuration: transitionDuration, animations: {
      animatingView.center = point
      animatingView.transform = CGAffineTransform(rotationAngle: angle / 100)
    }, completion: { _ in
      completion()
    })
  }

}

// MARK: - CAAnimationDelegate

extension DropDownAnimator: CAAnimationDelegate {
  public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    if let completion = completion {
      completion()
      self.completion = nil
    }
  }

}
