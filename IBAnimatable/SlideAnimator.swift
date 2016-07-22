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
    case .Right:
      self.transitionAnimationType = .Slide(toDirection: .Right, params: params)
      self.reverseAnimationType = .Slide(toDirection: .Left, params: params)
      self.interactiveGestureType = .Pan(fromDirection: .Right)
      reverse = true
    case .Top:
      self.transitionAnimationType = .Slide(toDirection: .Top, params: params)
      self.reverseAnimationType = .Slide(toDirection: .Bottom, params: params)
      self.interactiveGestureType = .Pan(fromDirection: .Top)
      reverse = false
    case .Bottom:
      self.transitionAnimationType = .Slide(toDirection: .Bottom, params: params)
      self.reverseAnimationType = .Slide(toDirection: .Top, params: params)
      self.interactiveGestureType = .Pan(fromDirection: .Bottom)
      reverse = true
    default:
      self.transitionAnimationType = .Slide(toDirection: .Left, params: params)
      self.reverseAnimationType = .Slide(toDirection: .Right, params: params)
      self.interactiveGestureType = .Pan(fromDirection: .Left)
      reverse = false
    }
    super.init()
  }
}

extension SlideAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    
    let travelDistance = horizontal ? containerView.bounds.width : containerView.bounds.height
    let travel = CGAffineTransformMakeTranslation(horizontal ? (reverse ? travelDistance : -travelDistance) : 0, horizontal ? 0 : (reverse ? travelDistance : -travelDistance))
    containerView.addSubview(toView)
    if fade {
      toView.alpha = 0
    }
    toView.transform = CGAffineTransformInvert(travel)
    animateSlideTransition(toView: toView, fromView: fromView, travel: travel) {
      fromView.transform = CGAffineTransformIdentity
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
  
}

// MARK: - Animation

private extension SlideAnimator {
  
  func animateSlideTransition(toView toView: UIView, fromView: UIView, travel: CGAffineTransform, completion: AnimatableCompletion) {
    UIView.animateWithDuration(transitionDuration, animations: {
      fromView.transform = travel
      toView.transform = CGAffineTransformIdentity
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
