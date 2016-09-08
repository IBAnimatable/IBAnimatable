//
//  Created by Tom Baranes on 08/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class SlideAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  fileprivate var fromDirection: TransitionDirection
  fileprivate var horizontal = false
  fileprivate var reverse = false
  fileprivate var fade = false
  
  public init(fromDirection: TransitionDirection, params: [String], transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    fade = params.contains("fade")
    horizontal = fromDirection.isHorizontal
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .slide(toDirection: .right, params: params)
      self.reverseAnimationType = .slide(toDirection: .left, params: params)
      self.interactiveGestureType = .pan(fromDirection: .right)
      reverse = true
    case .top:
      self.transitionAnimationType = .slide(toDirection: .top, params: params)
      self.reverseAnimationType = .slide(toDirection: .bottom, params: params)
      self.interactiveGestureType = .pan(fromDirection: .top)
      reverse = false
    case .bottom:
      self.transitionAnimationType = .slide(toDirection: .bottom, params: params)
      self.reverseAnimationType = .slide(toDirection: .top, params: params)
      self.interactiveGestureType = .pan(fromDirection: .bottom)
      reverse = true
    default:
      self.transitionAnimationType = .slide(toDirection: .left, params: params)
      self.reverseAnimationType = .slide(toDirection: .right, params: params)
      self.interactiveGestureType = .pan(fromDirection: .left)
      reverse = false
    }
    super.init()
  }
}

extension SlideAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
    guard let fromView = tempfromView, let toView = tempToView, let containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    
    let travelDistance = horizontal ? containerView.bounds.width : containerView.bounds.height
    let travel = CGAffineTransform(translationX: horizontal ? (reverse ? travelDistance : -travelDistance) : 0, y: horizontal ? 0 : (reverse ? travelDistance : -travelDistance))
    containerView.addSubview(toView)
    if fade {
      toView.alpha = 0
    }
    toView.transform = travel.inverted()
    animateSlideTransition(toView: toView, fromView: fromView, travel: travel) {
      fromView.transform = CGAffineTransform.identity
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }
  
}

// MARK: - Animation

private extension SlideAnimator {
  
  func animateSlideTransition(toView: UIView, fromView: UIView, travel: CGAffineTransform, completion: @escaping AnimatableCompletion) {
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
