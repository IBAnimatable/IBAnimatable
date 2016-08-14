//
//  Created by Tom Baranes on 13/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import QuartzCore

public class DropDownAnimator: NSObject, AnimatedPresenting {

  // MARK: - AnimatedPresenting
  public var transitionDuration: Duration = defaultTransitionDuration
  private var completion: AnimatableCompletion?

  // MARK: - Life cycle
  public init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    super.init()
  }

}

// MARK: - Animator

extension DropDownAnimator: UIViewControllerAnimatedTransitioning {

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
    animateDropDown(animatingView: animatingView, presenting: presenting) {
      if !presenting {
        fromView?.removeFromSuperview()
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }

}

// MARK: - Animation

private extension DropDownAnimator {

  func animateDropDown(animatingView animatingView: UIView, presenting: Bool, completion: AnimatableCompletion) {
    if presenting {
      animatePresengingDropDown(animatingView: animatingView, completion: completion)
    } else {
      animateDismissingDropDown(animatingView: animatingView, completion: completion)
    }
  }

  func animatePresengingDropDown(animatingView animatingView: UIView, completion: AnimatableCompletion) {
    let y = animatingView.center.y
    let animation = CAKeyframeAnimation(keyPath: "position.y")
    animation.values = [y - UIScreen.mainScreen().bounds.height, y + 20, y - 10, y]
    animation.keyTimes = [0, 0.5, 0.75, 1]
    animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
    animation.duration = transitionDuration
    animation.delegate = self
    self.completion = completion
    animatingView.layer.addAnimation(animation, forKey: "dropdown")
  }

  func animateDismissingDropDown(animatingView animatingView: UIView, completion: AnimatableCompletion) {
    var point = animatingView.center
    let angle = CGFloat(arc4random_uniform(100)) - 50
    point.y += UIScreen.mainScreen().bounds.height
    UIView.animateWithDuration(transitionDuration, animations: {
      animatingView.center = point
      animatingView.transform = CGAffineTransformMakeRotation(angle / 100)
    }, completion: { _ in
      completion()
    })
  }
  
}

// MARK: - CAAnimationDelegate

extension DropDownAnimator {

  public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    if let unwrappedCompletion = completion {
      unwrappedCompletion()
      completion = nil
    }
  }

}
