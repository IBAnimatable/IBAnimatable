//
//  Created by Tom Baranes on 08/05/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SlideAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var fromDirection: TransitionDirection
  private var horizontal = false
  private var reverse = false
  private var fade = false
  
  public init(fromDirection: TransitionDirection, params: [String], transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    fade = params.contains("fade")
    horizontal = fromDirection.isHorizontal
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .slide(toDirection: .right, params: params)
      self.reverseAnimationType = .slide(toDirection: .left, params: params)
      self.interactiveGestureType = .pan(fromDirection: .Right)
      reverse = true
    case .top:
      self.transitionAnimationType = .slide(toDirection: .top, params: params)
      self.reverseAnimationType = .slide(toDirection: .bottom, params: params)
      self.interactiveGestureType = .pan(fromDirection: .Top)
      reverse = false
    case .bottom:
      self.transitionAnimationType = .slide(toDirection: .bottom, params: params)
      self.reverseAnimationType = .slide(toDirection: .top, params: params)
      self.interactiveGestureType = .pan(fromDirection: .Bottom)
      reverse = true
    default:
      self.transitionAnimationType = .slide(toDirection: .left, params: params)
      self.reverseAnimationType = .slide(toDirection: .right, params: params)
      self.interactiveGestureType = .pan(fromDirection: .Left)
      reverse = false
    }
    super.init()
  }
}

extension SlideAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    
    let travelDistance = horizontal ? containerView.bounds.width : containerView.bounds.height
    let travel = CGAffineTransform(translationX: horizontal ? (reverse ? travelDistance : -travelDistance) : 0, y: horizontal ? 0 : (reverse ? travelDistance : -travelDistance))
    containerView.addSubview(toView)
    if fade {
      toView.alpha = 0
    }
    toView.transform = travel.invert()
    animateSlideTransition(toView, fromView: fromView, travel: travel) {
      fromView.transform = CGAffineTransform.identity
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
  
}

// MARK: - Animation

private extension SlideAnimator {
  
  func animateSlideTransition(_ toView: UIView, fromView: UIView, travel: CGAffineTransform, completion: AnimatableCompletion) {
    UIView.animate(withDuration: transitionDuration, animations: {
      fromView.transform = travel
      toView.transform = CGAffineTransform.identity
      if self.fade {
        fromView.alpha = 0
        toView.alpha = 1
      }
    },
    completion: { _ in
      completion()
    })
  }
  
}
