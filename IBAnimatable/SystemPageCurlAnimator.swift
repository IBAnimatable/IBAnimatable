//
//  Created by Tom Baranes on 28/03/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 System Page Curl Animator - To support Page Curl animation (Four page curl directions supported: left, right, top, bottom)
 */
public class SystemPageCurlAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var fromDirection: TransitionFromDirection
  private var animationOption: UIViewAnimationOptions
  
  init(fromDirection: TransitionFromDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .Top, .Left:
      self.transitionAnimationType = .SystemPageCurl(direction: .Top)
      self.reverseAnimationType = .SystemPageCurl(direction: .Bottom)
      self.animationOption = .TransitionCurlUp
    case .Bottom, .Right:
      self.transitionAnimationType = .SystemPageCurl(direction: .Bottom)
      self.reverseAnimationType = .SystemPageCurl(direction: .Top)
      self.animationOption = .TransitionCurlDown
    }
    
    super.init()
  }
}

extension SystemPageCurlAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let (tempFromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempFromView, toView = tempToView, _ = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    UIView.transitionFromView(fromView, toView: toView,
                              duration: transitionDuration(transitionContext), options: animationOption,
                              completion: { _ in
                                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
      }
    )
  }
}

