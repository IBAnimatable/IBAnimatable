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
  public var interactiveGestureType: InteractiveGestureType? = .Pan(direction: .Horizontal)
  
  // MARK: - Private params
  private var fromDirection: TransitionFromDirection
  
  // MARK: - Private fold transition
  private var transform: CATransform3D = CATransform3DIdentity
  private var reverse: Bool = false
  
  // MARK: - Life cycle
  public init(fromDirection: TransitionFromDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .Right:
      self.transitionAnimationType = .Turn(direction: .Right)
      self.reverseAnimationType = .Turn(direction: .Left)
      self.interactiveGestureType = .Pan(direction: .Left)
      reverse = true
    case .Top:
      self.transitionAnimationType = .Turn(direction: .Top)
      self.reverseAnimationType = .Turn(direction: .Bottom)
      self.interactiveGestureType = .Pan(direction: .Bottom)
      reverse = false
    case .Bottom:
      self.transitionAnimationType = .Turn(direction: .Bottom)
      self.reverseAnimationType = .Turn(direction: .Top)
      self.interactiveGestureType = .Pan(direction: .Top)
      reverse = true
    default:
      self.transitionAnimationType = .Turn(direction: .Left)
      self.reverseAnimationType = .Turn(direction: .Right)
      self.interactiveGestureType = .Pan(direction: .Right)
      reverse = false      
    }
    super.init()
  }
}

extension TurnAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    containerView.addSubview(toView)
    transform.m34 = -0.002
    containerView.layer.sublayerTransform = transform
    toView.frame = fromView.frame
    animateTurnTransition(fromView: fromView, toView: toView) {
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }

  private func animateTurnTransition(fromView fromView: UIView, toView: UIView, completion: AnimatableCompletion) {
    let factor = reverse ? 1.0 : -1.0;
    toView.layer.transform = rotate(factor * -M_PI_2)
    UIView.animateKeyframesWithDuration(transitionDuration, delay: 0.0, options: .LayoutSubviews, animations: {
      UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5) {
            fromView.layer.transform = self.rotate(factor * M_PI_2)
      }

      UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5) {
        toView.layer.transform =  self.rotate(0.0)
      }
    }) { _ in
        completion()
    }
  }
  
}

// MARK: - Helpers

private extension TurnAnimator {

  func rotate(angle: Double) -> CATransform3D {
    if fromDirection == .Left || fromDirection == .Right {
      return  CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    } else {
      return  CATransform3DMakeRotation(CGFloat(angle), 1.0, 0.0, 0.0)
    }
  }

}