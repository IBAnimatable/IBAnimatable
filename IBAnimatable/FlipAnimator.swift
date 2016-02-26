//
//  Created by Jake Lin on 2/25/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Cube Animator - To support Flip animation (Four flip directions supported: left, right, top, bottom)
 */
public class FlipAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: String
  public var transitionDuration: Duration = 0.35
  public var reverseAnimationType: String?
  
  // MARK: - private
  private var fromDirection: TransitionFromDirection
  private var animationOption: UIViewAnimationOptions
  
  init(fromDirection: TransitionFromDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .FromLeft:
      self.transitionAnimationType = String(TransitionAnimationType.FlipFromLeft)
      self.reverseAnimationType = String(TransitionAnimationType.FlipFromRight)
      self.animationOption = .TransitionFlipFromLeft
    case .FromRight:
      self.transitionAnimationType = String(TransitionAnimationType.FlipFromRight)
      self.reverseAnimationType = String(TransitionAnimationType.FlipFromRight)
      self.animationOption = .TransitionFlipFromRight
    case .FromTop:
      self.transitionAnimationType = String(TransitionAnimationType.FlipFromTop)
      self.reverseAnimationType = String(TransitionAnimationType.FlipFromRight)
      self.animationOption = .TransitionFlipFromTop
    case .FromBottom:
      self.transitionAnimationType = String(TransitionAnimationType.FlipFromBottom)
      self.reverseAnimationType = String(TransitionAnimationType.FlipFromRight)
      self.animationOption = .TransitionFlipFromBottom
    }
    
    super.init()
  }
}

extension FlipAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let (tempFromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempFromView, toView = tempToView, _ = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    UIView.transitionFromView(fromView, toView: toView, duration: transitionDuration(transitionContext), options: animationOption) { _ in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
}
