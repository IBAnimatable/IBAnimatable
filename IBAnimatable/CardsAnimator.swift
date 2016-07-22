//
//  Created by Tom Baranes on 01/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class CardsAnimator: NSObject, AnimatedTransitioning {
  
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var fromDirection: TransitionDirection
  
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.fromDirection = fromDirection
    
    switch fromDirection {
    case .Backward:
      self.transitionAnimationType = .Cards(direction: .Backward)
      self.reverseAnimationType = .Cards(direction: .Forward)
    default:
      self.transitionAnimationType = .Cards(direction: .Forward)
      self.reverseAnimationType = .Cards(direction: .Backward)
    }
    
    super.init()
  }
}

extension CardsAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView, toView = tempToView, containerView = tempContainerView else {
      transitionContext.completeTransition(true)
      return
    }
    
    if fromDirection == .Forward {
      executeForwardAnimation(transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    } else {
      executeBackwardAnimation(transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    }
  }
  
}

// MARK: - Forward

private extension CardsAnimator {
  
  func executeBackwardAnimation(transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView, toView: UIView) {
    let frame = fromView.frame
    var offScreenFrame = frame
    offScreenFrame.origin.y = offScreenFrame.height
    toView.frame = offScreenFrame
    containerView.insertSubview(toView, aboveSubview: fromView)
    let t1 = firstTransform()
    let t2 = secondTransformWithView(fromView)
    UIView.animateKeyframesWithDuration(transitionDuration, delay: 0.0, options: .CalculationModeCubic, animations: {
      UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.4) {
        fromView.layer.transform = t1
        fromView.alpha = 0.6
      }

      UIView.addKeyframeWithRelativeStartTime(0.2, relativeDuration: 0.4) {
        fromView.layer.transform = t2
      }

      UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 0.2) {        
        toView.frame = toView.frame.offsetBy(dx: 0.0, dy: -30.0)
      }
      
      UIView.addKeyframeWithRelativeStartTime(0.8, relativeDuration: 0.2) {
        toView.frame = frame
      }

    }) { _ in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
  
}

// MARK: - Reverse

private extension CardsAnimator {
  
  func executeForwardAnimation(transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView, toView: UIView) {
    let frame = fromView.frame
    toView.frame = frame
    let scale = CATransform3DIdentity
    toView.layer.transform = CATransform3DScale(scale, 0.6, 0.6, 1)
    toView.alpha = 0.6
    
    containerView.insertSubview(toView, belowSubview: fromView)
    var frameOffScreen = frame
    frameOffScreen.origin.y = frame.height
    let t1 = firstTransform()
    
    UIView.animateKeyframesWithDuration(transitionDuration, delay: 0.0, options: .CalculationModeCubic, animations: {
      UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5) {
        fromView.frame = frameOffScreen
      }
      
      UIView.addKeyframeWithRelativeStartTime(0.35, relativeDuration: 0.35) {
        toView.layer.transform = t1
        toView.alpha = 1.0
      }
      
      UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.25) {
        toView.layer.transform = CATransform3DIdentity
      }
      
    }) { _ in
      if transitionContext.transitionWasCancelled() {
        toView.layer.transform = CATransform3DIdentity
        toView.alpha = 1.0
      }
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
  
}

// MARK: - Helper

private extension CardsAnimator {

  func firstTransform() -> CATransform3D {
      var t1 = CATransform3DIdentity
      t1.m34 = 1.0 / -900
      t1 = CATransform3DScale(t1, 0.95, 0.95, 1)
      t1 = CATransform3DRotate(t1, 15.0 * CGFloat(M_PI) / 180.0, 1, 0, 0)
      return t1
  }

  func secondTransformWithView(view: UIView) -> CATransform3D {
    var t2 = CATransform3DIdentity
    t2.m34 = firstTransform().m34
    t2 = CATransform3DTranslate(t2, 0, view.frame.size.height * -0.08, 0)
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1)
    return t2
  }
  
}
