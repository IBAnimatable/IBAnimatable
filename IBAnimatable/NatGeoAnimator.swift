//
//  Created by Tom Baranes on 24/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class NatGeoAnimator: NSObject, AnimatedTransitioning {

  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?

  // MARK: - private
  fileprivate var fromDirection: TransitionAnimationType.Direction
  fileprivate let firstPartRatio: Double = 0.8

  // MARK: - Life cycle

  public init(from direction: TransitionAnimationType.Direction, duration: Duration) {
    transitionDuration = duration
    fromDirection = direction
    transitionAnimationType = .natGeo(to: direction)
    reverseAnimationType = .natGeo(to: direction.opposite)

    super.init()
  }
}

extension NatGeoAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
    guard let fromView = tempfromView,
              let toView = tempToView,
              let containerView = tempContainerView else {
        transitionContext.completeTransition(true)
      return
    }

    let (_, tempToViewController, _) = retrieveViewControllers(transitionContext: transitionContext)
    if let toViewController = tempToViewController {
      toView.frame = transitionContext.finalFrame(for: toViewController)
    }

    containerView.addSubview(toView)
    containerView.addSubview(fromView)
    if fromDirection == .left {
      executeLeftAnimation(context: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    } else {
      executeRightAnimations(context: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    }
  }

}

// MARK: - Left

private extension NatGeoAnimator {

  func executeLeftAnimation(context transitionContext: UIViewControllerContextTransitioning,
                            containerView: UIView,
                            fromView: UIView,
                            toView: UIView) {
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
      if transitionContext.transitionWasCancelled {
        containerView.bringSubview(toFront: fromView)
        fromView.isUserInteractionEnabled = true
      }

      self.animationDidFinish(transitionContext, containerView: containerView, fromView: fromView, toView: toView)
    }
  }

}

// MARK: - Right

private extension NatGeoAnimator {

  func executeRightAnimations(context transitionContext: UIViewControllerContextTransitioning,
                              containerView: UIView,
                              fromView: UIView,
                              toView: UIView) {

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
      if transitionContext.transitionWasCancelled {
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
    return CGFloat((degrees / 180) * .pi)
  }

  func animationDidFinish(_ transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView, toView: UIView) {
    fromView.layer.transform = CATransform3DIdentity
    toView.layer.transform = CATransform3DIdentity
    containerView.layer.transform = CATransform3DIdentity
    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
  }

}
