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
  public var interactiveGestureType: InteractiveGestureType? = .pan(fromDirection: .Horizontal)

  // MARK: - private
  private var direction: TransitionDirection
  
  public init(direction: TransitionDirection, transitionDuration: Duration) {
    self.direction = direction
    self.transitionDuration = transitionDuration
    
    switch direction {
    case .in:
      self.transitionAnimationType = .fade(direction: .in)
      self.reverseAnimationType = .fade(direction: .out)
    case .out:
      self.transitionAnimationType = .fade(direction: .out)
      self.reverseAnimationType = .fade(direction: .in)
    default:
      self.transitionAnimationType = .fade(direction: .cross)
      self.reverseAnimationType = .fade(direction: .cross)
    }
    
    super.init()
  }
}

extension FadeAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    switch direction {
    case .in:
      toView.alpha = 0
      containerView.addSubview(toView)
    case .out:
      containerView.insertSubview(toView, belowSubview: fromView)
    default:
      toView.alpha = 0
      containerView.addSubview(toView)
    }
    
    UIView.animate(withDuration: transitionDuration(transitionContext),
      animations: {
        switch self.direction {
        case .in:
          toView.alpha = 1
        case .out:
          fromView.alpha = 0
        default:
          fromView.alpha = 0
          toView.alpha = 1
        }
      },
      completion: { _ in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    })
  }
}
