//
//  Created by Tom Baranes on 01/05/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class TurnAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType? = .pan(fromDirection: .Horizontal)
  
  // MARK: - Private params
  private var fromDirection: TransitionDirection
  
  // MARK: - Private fold transition
  private var transform: CATransform3D = CATransform3DIdentity
  private var reverse: Bool = false
  
  // MARK: - Life cycle
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .turn(fromDirection: .right)
      self.reverseAnimationType = .turn(fromDirection: .left)
      self.interactiveGestureType = .pan(fromDirection: .Left)
      reverse = true
    case .top:
      self.transitionAnimationType = .turn(fromDirection: .top)
      self.reverseAnimationType = .turn(fromDirection: .bottom)
      self.interactiveGestureType = .pan(fromDirection: .Bottom)
      reverse = false
    case .bottom:
      self.transitionAnimationType = .turn(fromDirection: .bottom)
      self.reverseAnimationType = .turn(fromDirection: .top)
      self.interactiveGestureType = .pan(fromDirection: .Top)
      reverse = true
    default:
      self.transitionAnimationType = .turn(fromDirection: .left)
      self.reverseAnimationType = .turn(fromDirection: .right)
      self.interactiveGestureType = .pan(fromDirection: .Right)
      reverse = false      
    }
    super.init()
  }
}

extension TurnAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    containerView.addSubview(toView)
    transform.m34 = -0.002
    containerView.layer.sublayerTransform = transform
    toView.frame = fromView.frame
    animateTurnTransition(fromView, toView: toView) {
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }

  private func animateTurnTransition(_ fromView: UIView, toView: UIView, completion: AnimatableCompletion) {
    let factor = reverse ? 1.0 : -1.0
    toView.layer.transform = rotate(factor * -M_PI_2)
    UIView.animateKeyframes(withDuration: transitionDuration, delay: 0.0, options: .layoutSubviews, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
            fromView.layer.transform = self.rotate(factor * M_PI_2)
      }

      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
        toView.layer.transform =  self.rotate(0.0)
      }
    }) { _ in
        completion()
    }
  }
  
}

// MARK: - Helpers

private extension TurnAnimator {

  func rotate(_ angle: Double) -> CATransform3D {
    if fromDirection == .left || fromDirection == .right {
      return  CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    } else {
      return  CATransform3DMakeRotation(CGFloat(angle), 1.0, 0.0, 0.0)
    }
  }

}
