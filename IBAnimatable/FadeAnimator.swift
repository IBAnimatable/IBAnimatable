//
//  Created by Jake Lin on 2/27/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class FadeAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType? = .Pan(fromDirection: .Horizontal)

  // MARK: - private
  private var direction: TransitionDirection
  
  public init(direction: TransitionDirection, transitionDuration: Duration) {
    self.direction = direction
    self.transitionDuration = transitionDuration
    
    switch direction {
    case .In:
      self.transitionAnimationType = .FadeIn
      self.reverseAnimationType = .FadeOut
    case .Out:
      self.transitionAnimationType = .FadeOut
      self.reverseAnimationType = .FadeIn
    default:
      self.transitionAnimationType = .Fade
      self.reverseAnimationType = .Fade
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
    
    switch transitionAnimationType {
    case .Fade:
      toView.alpha = 0
      containerView.addSubview(toView)
    case .FadeIn:
      toView.alpha = 0
      containerView.addSubview(toView)
    case .FadeOut:
      containerView.insertSubview(toView, belowSubview: fromView)
    default:
      transitionContext.completeTransition(true)
      return
    }
    
    UIView.animateWithDuration(transitionDuration(transitionContext),
      animations: {
        switch self.transitionAnimationType {
        case .Fade:
          fromView.alpha = 0
          toView.alpha = 1
        case .FadeIn:
          toView.alpha = 1
        case .FadeOut:
          fromView.alpha = 0
        default:
          transitionContext.completeTransition(true)
          return
        }
      },
      completion: { _ in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    })
  }
}
