//
//  Created by Tom Baranes on 01/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class TurnAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType? = .Pan(fromDirection: .Horizontal)
  
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
    case .Right:
      self.transitionAnimationType = .Turn(fromDirection: .Right)
      self.reverseAnimationType = .Turn(fromDirection: .Left)
      self.interactiveGestureType = .Pan(fromDirection: .Left)
      reverse = true
    case .Top:
      self.transitionAnimationType = .Turn(fromDirection: .Top)
      self.reverseAnimationType = .Turn(fromDirection: .Bottom)
      self.interactiveGestureType = .Pan(fromDirection: .Bottom)
      reverse = false
    case .Bottom:
      self.transitionAnimationType = .Turn(fromDirection: .Bottom)
      self.reverseAnimationType = .Turn(fromDirection: .Top)
      self.interactiveGestureType = .Pan(fromDirection: .Top)
      reverse = true
    default:
      self.transitionAnimationType = .Turn(fromDirection: .Left)
      self.reverseAnimationType = .Turn(fromDirection: .Right)
      self.interactiveGestureType = .Pan(fromDirection: .Right)
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
    let factor = reverse ? 1.0 : -1.0
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
