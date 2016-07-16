//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class InvertAnimator: NSObject, AnimatedPresenting {

  // MARK: - AnimatedPresenting  
  public var transitionDuration: Duration = defaultTransitionDuration

  // MARK: - Life cycle
  public init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    super.init()
  }

}

// MARK: - Animator

extension InvertAnimator: UIViewControllerAnimatedTransitioning {

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
    animateInvert(animatingView: animatingView, presenting: presenting) {
      if !presenting {
        fromView?.removeFromSuperview()
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }

}

// MARK: - Animation

private extension InvertAnimator {

  func animateInvert(animatingView animatingView: UIView, presenting: Bool, completion: AnimatableCompletion) {
    if presenting {
      animatePresengingInvert(animatingView: animatingView, completion: completion)
    } else {
      animateDismissingInvert(animatingView: animatingView, completion: completion)
    }
  }

  func animatePresengingInvert(animatingView animatingView: UIView, completion: AnimatableCompletion) {
    let bounceAnimation = animation(completion)
    animatingView.layer.addAnimation(bounceAnimation, forKey: "bounce")
  }

  func animateDismissingInvert(animatingView animatingView: UIView, completion: AnimatableCompletion) {
    let bounceAnimation = animation(completion)
    bounceAnimation.speed = -1
    animatingView.layer.addAnimation(bounceAnimation, forKey: "bounce")
  }

}

// MARK: CAAnimation

extension InvertAnimator {

  func animation(completion: AnimatableCompletion) -> CAAnimation {
    let bounceAnimation = CAKeyframeAnimation(keyPath: "transform")
    bounceAnimation.fillMode = kCAFillModeBoth
    bounceAnimation.removedOnCompletion = true
    bounceAnimation.duration = transitionDuration
    bounceAnimation.values = [
      NSValue(CATransform3D: CATransform3DMakeScale(0.01, 0.01, 0.01)),
      NSValue(CATransform3D: CATransform3DMakeScale(0.9, 0.9, 0.9)),
      NSValue(CATransform3D: CATransform3DMakeScale(1.1, 1.1, 1.1)),
      NSValue(CATransform3D: CATransform3DIdentity)
    ]
    bounceAnimation.keyTimes = [0.0, 0.5, 0.75, 1.0]
    bounceAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
    bounceAnimation.delegate = self

    let completionHandler: AnyObject = unsafeBitCast(completion as @convention(block) () -> Void, AnyObject.self)
    bounceAnimation.setValue(completionHandler, forKey: "completion")
    return bounceAnimation
  }

  typealias MyFunBlock = @objc_block () -> Void
  public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    let completion = unsafeBitCast(anim.valueForKey("completion"), MyFunBlock.self) as MyFunBlock
    completion()
  }

}
