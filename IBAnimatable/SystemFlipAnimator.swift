//
//  Created by Jake Lin on 2/25/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 System Flip Animator - To support Flip animation (Four flip directions supported: left, right, top, bottom)
 */
public class SystemFlipAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = 0.35
  public var reverseAnimationType: TransitionAnimationType?
  
  // MARK: - private
  private var fromDirection: TransitionFromDirection
  private var animationOption: UIViewAnimationOptions
  
  init(fromDirection: TransitionFromDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .FromLeft:
      self.transitionAnimationType = .SystemFlipFromLeft
      self.reverseAnimationType = .SystemFlipFromRight
      self.animationOption = .TransitionFlipFromLeft
    case .FromRight:
      self.transitionAnimationType = .SystemFlipFromRight
      self.reverseAnimationType = .SystemFlipFromRight
      self.animationOption = .TransitionFlipFromRight
    case .FromTop:
      self.transitionAnimationType = .SystemFlipFromTop
      self.reverseAnimationType = .SystemFlipFromRight
      self.animationOption = .TransitionFlipFromTop
    case .FromBottom:
      self.transitionAnimationType = .SystemFlipFromBottom
      self.reverseAnimationType = .SystemFlipFromRight
      self.animationOption = .TransitionFlipFromBottom
    }
    
    super.init()
  }
}

extension SystemFlipAnimator: UIViewControllerAnimatedTransitioning {
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
