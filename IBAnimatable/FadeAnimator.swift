//
//  Created by Jake Lin on 2/27/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
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
      self.transitionAnimationType = .Fade(direction: .In)
      self.reverseAnimationType = .Fade(direction: .Out)
    case .Out:
      self.transitionAnimationType = .Fade(direction: .Out)
      self.reverseAnimationType = .Fade(direction: .In)
    default:
      self.transitionAnimationType = .Fade(direction: .Cross)
      self.reverseAnimationType = .Fade(direction: .Cross)
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
    guard let containerView = tempContainerView, toView = tempToView else {
      transitionContext.completeTransition(true)
      return
    }

    switch direction {
    case .In:
      toView.alpha = 0
      containerView.addSubview(toView)
    case .Out:
      if let fromView = tempfromView {
        containerView.insertSubview(toView, belowSubview: fromView)
      }
    default:
      toView.alpha = 0
      containerView.addSubview(toView)
    }
    
    UIView.animateWithDuration(transitionDuration(transitionContext),
      animations: {
        switch self.direction {
        case .In:
          toView.alpha = 1
        case .Out:
          tempfromView?.alpha = 0
        default:
          tempfromView?.alpha = 0
          toView.alpha = 1
        }
      },
      completion: { _ in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    })
  }
}
