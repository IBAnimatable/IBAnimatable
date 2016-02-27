//
//  Created by Jake Lin on 2/27/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class FadeAnimator: NSObject , AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = 0.35
  public var reverseAnimationType: TransitionAnimationType?

  // MARK: - private
  private var fadeType: TransitionFadeType
  
  init(fadeType: TransitionFadeType, transitionDuration: Duration) {
    self.fadeType = fadeType
    self.transitionDuration = transitionDuration
    
    switch fadeType {
    case .Fade:
      self.transitionAnimationType = TransitionAnimationType.Fade
      self.reverseAnimationType = TransitionAnimationType.Fade
    case .FadeIn:
      self.transitionAnimationType = TransitionAnimationType.FadeIn
      self.reverseAnimationType = TransitionAnimationType.FadeOut
    case .FadeOut:
      self.transitionAnimationType = TransitionAnimationType.FadeOut
      self.reverseAnimationType = TransitionAnimationType.FadeIn
    }
    
    super.init()
  }
}

extension FadeAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    switch fadeType {
    case .Fade:
      toView.alpha = 0
      containerView.addSubview(toView)
    case .FadeIn:
      toView.alpha = 0
      containerView.addSubview(toView)
    case .FadeOut:
      containerView.insertSubview(toView, belowSubview: fromView)
    }
    
    UIView.animateWithDuration(transitionDuration(transitionContext),
      animations: {
        switch self.fadeType {
        case .Fade:
          fromView.alpha = 0
          toView.alpha = 1
        case .FadeIn:
          toView.alpha = 1
        case .FadeOut:
          fromView.alpha = 0
        }
      },
      completion: { _ in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    })
  }
}