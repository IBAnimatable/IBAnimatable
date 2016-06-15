//
//  Created by Tom Baranes on 24/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class NatGeoAnimator: NSObject, AnimatedTransitioning {
  
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var fromDirection: TransitionDirection
  private let firstPartRatio: Double = 0.8
  
  // MARK: - Life cycle
  
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.fromDirection = fromDirection
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .natGeo(toDirection: .right)
      self.reverseAnimationType = .natGeo(toDirection: .left)
    default:
      self.transitionAnimationType = .natGeo(toDirection: .left)
      self.reverseAnimationType = .natGeo(toDirection: .right)
    }
    
    super.init()
  }
}

extension NatGeoAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext)
    guard let fromView = tempfromView,
              toView = tempToView,
              containerView = tempContainerView else {
        transitionContext.completeTransition(true)
      return
    }
    
    containerView.addSubview(toView)
    containerView.addSubview(fromView)
    if fromDirection == .left {
      executeLeftAnimation(transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    } else {
      executeRightAnimations(transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    }
  }
  
}

// MARK: - Left

private extension NatGeoAnimator {
  
  func executeLeftAnimation(_ transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView, toView: UIView) {
    fromView.isUserInteractionEnabled = false
    var fromLayer = fromView.layer
    var toLayer = toView.layer
    
    let oldFrame = fromLayer.frame
    fromLayer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
    fromLayer.frame = oldFrame
    sourceFirstTransform(&fromLayer)
    destinationFirstTransform(&toLayer)

    UIView.animateKeyframes(withDuration: transitionDuration, delay: 0.0, options: .calculationModeCubic, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
        self.destinationLastTransform(&toLayer)
      }
      
      UIView.addKeyframe(withRelativeStartTime: 1.0 - self.firstPartRatio, relativeDuration: self.firstPartRatio) {
        self.sourceLastTransform(&fromLayer)
      }
    }) { _ in
      if transitionContext.transitionWasCancelled() {
        containerView.bringSubview(toFront: fromView)
        fromView.isUserInteractionEnabled = true
      }

      self.animationDidFinish(transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    }
  }
  
}

// MARK: - Right

private extension NatGeoAnimator {
  
  func executeRightAnimations(_ transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView, toView: UIView) {

    toView.isUserInteractionEnabled = true
    var fromLayer = toView.layer
    var toLayer = fromView.layer

    let oldFrame = fromLayer.frame
    fromLayer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
    fromLayer.frame = oldFrame    
    sourceLastTransform(&fromLayer)
    destinationLastTransform(&toLayer)
    
    UIView.animateKeyframes(withDuration: transitionDuration, delay: 0.0, options: .calculationModeCubic, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: self.firstPartRatio) {
        self.sourceFirstTransform(&fromLayer)
      }

      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
        self.destinationFirstTransform(&toLayer)
      }
    }) { _ in
      if transitionContext.transitionWasCancelled() {
        containerView.bringSubview(toFront: fromView)
        toView.isUserInteractionEnabled = false
      }

      self.animationDidFinish(transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    }
  }
  
}

// MARK: - Helpers

private extension NatGeoAnimator {

  func sourceFirstTransform(_ layer: inout CALayer) {
    var transform = CATransform3DIdentity
    transform.m34 = 1.0 / -500
    transform = CATransform3DTranslate(transform, 0.0, 0.0, 0.0)
    layer.transform = transform
  }
  
  func sourceLastTransform(_ layer: inout CALayer) {
    var transform = CATransform3DIdentity
    transform.m34 = 1.0 / -500.0
    transform = CATransform3DRotate(transform, radianFromDegree(80), 0.0, 1.0, 0.0)
    transform = CATransform3DTranslate(transform, 0.0, 0.0, -30.0)
    transform = CATransform3DTranslate(transform, 170.0, 0.0, 0.0)
    layer.transform = transform
  }

  func destinationFirstTransform(_ layer: inout CALayer) {
    var transform = CATransform3DIdentity
    transform.m34 = 1.0 / -500.0
    transform = CATransform3DRotate(transform, radianFromDegree(5.0), 0.0, 0.0, 1.0)
    transform = CATransform3DTranslate(transform, 320.0, -40.0, 150.0)
    transform = CATransform3DRotate(transform, radianFromDegree(-45), 0.0, 1.0, 0.0)
    transform = CATransform3DRotate(transform, radianFromDegree(10), 1.0, 0.0, 0.0)
    layer.transform = transform
  }

  func destinationLastTransform(_ layer: inout CALayer) {
    var transform = CATransform3DIdentity
    transform.m34 = 1.0 / -500
    transform = CATransform3DRotate(transform, radianFromDegree(0), 0.0, 0.0, 1.0)
    transform = CATransform3DTranslate(transform, 0.0, 0.0, 0.0)
    transform = CATransform3DRotate(transform, radianFromDegree(0), 0.0, 1.0, 0.0)
    transform = CATransform3DRotate(transform, radianFromDegree(0), 1.0, 0.0, 0.0)
    layer.transform = transform
  }

  func radianFromDegree(_ degrees: Double) -> CGFloat {
    return CGFloat((degrees / 180) * M_PI)
  }

  func animationDidFinish(_ transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView, toView: UIView) {
    fromView.layer.transform = CATransform3DIdentity
    toView.layer.transform = CATransform3DIdentity
    containerView.layer.transform = CATransform3DIdentity
    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
  }
  
}
