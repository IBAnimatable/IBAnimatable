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
  fileprivate var fromDirection: TransitionAnimationType.Direction
  fileprivate var isHorizontal = false
  fileprivate var isReverse = false
  fileprivate var isFade = false
  
  public init(from direction: TransitionAnimationType.Direction, isFade: Bool, transitionDuration: Duration) {
    fromDirection = direction
    self.transitionDuration = transitionDuration
    self.isFade = isFade
    isHorizontal = fromDirection.isHorizontal
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .slide(to: .right, isFade: isFade)
      self.reverseAnimationType = .slide(to: .left, isFade: isFade)
      self.interactiveGestureType = .pan(from: .right)
      isReverse = true
    case .top:
      self.transitionAnimationType = .slide(to: .top, isFade: isFade)
      self.reverseAnimationType = .slide(to: .bottom, isFade: isFade)
      self.interactiveGestureType = .pan(from: .top)
      isReverse = false
    case .bottom:
      self.transitionAnimationType = .slide(to: .bottom, isFade: isFade)
      self.reverseAnimationType = .slide(to: .top, isFade: isFade)
      self.interactiveGestureType = .pan(from: .bottom)
      isReverse = true
    default:
      self.transitionAnimationType = .slide(to: .left, isFade: isFade)
      self.reverseAnimationType = .slide(to: .right, isFade: isFade)
      self.interactiveGestureType = .pan(from: .left)
      isReverse = false
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
    
    let travelDistance = isHorizontal ? containerView.bounds.width : containerView.bounds.height
    let travel = CGAffineTransform(translationX: isHorizontal ? (isReverse ? travelDistance : -travelDistance) : 0, y: isHorizontal ? 0 : (isReverse ? travelDistance : -travelDistance))
    containerView.addSubview(toView)
    if isFade {
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
      if self.isFade {
        fromView.alpha = 0
        toView.alpha = 1
      }
    },
    completion: { _ in
      completion()
    })
  }
}
