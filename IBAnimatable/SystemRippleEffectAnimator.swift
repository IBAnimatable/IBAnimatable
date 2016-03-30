//
//  ViewController.swift
//  IBAnimatableApp
//
//  Created by Tom Baranes on 30/03/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 System Ripple Animator - To support 3D animation (Four rotation directions supported: left, right, top, bottom)
 */
public class SystemRippleEffectAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.transitionAnimationType = .SystemRippleEffect
    self.reverseAnimationType = .SystemRippleEffect
    super.init()
  }
}

extension SystemRippleEffectAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.RippleEffect, subtype: nil)
  }
}
