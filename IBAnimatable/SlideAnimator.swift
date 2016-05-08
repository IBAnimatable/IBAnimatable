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
  private var fromDirection: TransitionFromDirection
  private var horizontal = false
  private var reverse = false
  private var fade = false
  
  public init(fromDirection: TransitionFromDirection, params: [String], transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    self.fade = params.contains("fade")
    
    switch fromDirection {
    case .Right:
      self.transitionAnimationType = .Slide(direction: .Right, params: params)
      self.reverseAnimationType = .Slide(direction: .Left, params: params)
      self.horizontal = true
      self.reverse = true
    case .Top:
      self.transitionAnimationType = .Slide(direction: .Top, params: params)
      self.reverseAnimationType = .Slide(direction: .Bottom, params: params)
      self.horizontal = false
      self.reverse = false
    case .Bottom:
      self.transitionAnimationType = .Slide(direction: .Bottom, params: params)
      self.reverseAnimationType = .Slide(direction: .Top, params: params)
      self.horizontal = false
      self.reverse = true
    default:
      self.transitionAnimationType = .Slide(direction: .Left, params: params)
      self.reverseAnimationType = .Slide(direction: .Right, params: params)
      self.horizontal = true
      self.reverse = false
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
    }) { _ in
        completion()
    }
  }
  
}
