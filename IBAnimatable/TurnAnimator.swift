//
//  Created by Tom Baranes on 01/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class TurnAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  open var transitionAnimationType: TransitionAnimationType
  open var transitionDuration: Duration = defaultTransitionDuration
  open var reverseAnimationType: TransitionAnimationType?
  open var interactiveGestureType: InteractiveGestureType? = .pan(fromDirection: .horizontal)
  
  // MARK: - Private params
  fileprivate var fromDirection: TransitionDirection
  
  // MARK: - Private fold transition
  fileprivate var transform: CATransform3D = CATransform3DIdentity
  fileprivate var reverse: Bool = false
  
  // MARK: - Life cycle
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .turn(fromDirection: .right)
      self.reverseAnimationType = .turn(fromDirection: .left)
      self.interactiveGestureType = .pan(fromDirection: .left)
      reverse = true
    case .top:
      self.transitionAnimationType = .turn(fromDirection: .top)
      self.reverseAnimationType = .turn(fromDirection: .bottom)
      self.interactiveGestureType = .pan(fromDirection: .bottom)
      reverse = false
    case .bottom:
      self.transitionAnimationType = .turn(fromDirection: .bottom)
      self.reverseAnimationType = .turn(fromDirection: .top)
      self.interactiveGestureType = .pan(fromDirection: .top)
      reverse = true
    default:
      self.transitionAnimationType = .turn(fromDirection: .left)
      self.reverseAnimationType = .turn(fromDirection: .right)
      self.interactiveGestureType = .pan(fromDirection: .right)
      reverse = false      
    }
    super.init()
  }
}

extension TurnAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return getTransitionDuration(using: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = getViews(using: transitionContext)
    guard let fromView = tempfromView, let toView = tempToView, let containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    containerView.addSubview(toView)
    transform.m34 = -0.002
    containerView.layer.sublayerTransform = transform
    toView.frame = fromView.frame
    animateTurnTransition(fromView: fromView, toView: toView) {
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }

  fileprivate func animateTurnTransition(fromView: UIView, toView: UIView, completion: AnimatableCompletion) {
    let factor = reverse ? 1.0 : -1.0
    toView.layer.transform = rotate(angle: factor * -.pi * 2)
    UIView.animateKeyframes(withDuration: transitionDuration, delay: 0.0, options: .layoutSubviews, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
            fromView.layer.transform = self.rotate(angle: factor * .pi * 2)
      }

      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
        toView.layer.transform =  self.rotate(angle: 0.0)
      }
    }) { _ in
        completion()
    }
  }
  
}

// MARK: - Helpers

private extension TurnAnimator {

  func rotate(angle: Double) -> CATransform3D {
    if fromDirection == .left || fromDirection == .right {
      return  CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    } else {
      return  CATransform3DMakeRotation(CGFloat(angle), 1.0, 0.0, 0.0)
    }
  }

}
