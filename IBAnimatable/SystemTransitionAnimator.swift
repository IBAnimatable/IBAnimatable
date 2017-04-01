//
//  SystemTransitionAnimator.swift
//  IBAnimatable
//
//  Created by Steven on 4/1/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit

class SystemTransitionAnimator: NSObject, AnimatedTransitioning {

  var transitionDuration: Duration
  var transitionAnimationType: TransitionAnimationType
  var reverseAnimationType: TransitionAnimationType?
  var interactiveGestureType: InteractiveGestureType?
  var systemTransitionType: TransitionAnimationType.SystemTransitionType
  var systemTransitionSubtype: String?

  init(systemType: TransitionAnimationType.SystemTransitionType, duration: Duration, direction: TransitionAnimationType.Direction? = nil) {

    self.systemTransitionType = systemType
    self.transitionDuration = duration

    if let direction = direction {
      self.transitionAnimationType = TransitionAnimationType(systemType: systemType, direction: direction)

      switch systemType {
      case .cube, .flip, .moveIn, .push, .reveal:
        self.systemTransitionSubtype = direction.caTransitionSubtype
        self.interactiveGestureType = .pan(from: direction.opposingGesture)
      case .cameraIrisHollowClose, .cameraIrisHollowOpen, .cameraIris:
        self.interactiveGestureType = .pinch(direction: direction.opposingGesture)
      case .pageUnCurl, .pageCurl:
        self.interactiveGestureType = .pan(from: direction.opposingGesture)
      default:
        break
      }
    } else {
      self.transitionAnimationType = TransitionAnimationType(systemType: systemType)
      self.systemTransitionSubtype = systemType == .rotate ? "90" : nil
    }

    self.reverseAnimationType = transitionAnimationType.reversed
    super.init()
  }

  // MARK: - Helper Methods (Private)
  fileprivate func toView(using transitionContext: UIViewControllerContextTransitioning) -> UIView? {
    return transitionContext.view(forKey: UITransitionContextViewKey.to)
  }

  fileprivate func fromView(using transitionContext: UIViewControllerContextTransitioning) -> UIView? {
    return transitionContext.view(forKey: UITransitionContextViewKey.from)
  }

  fileprivate func toViewController(using transitionContext: UIViewControllerContextTransitioning) -> UIViewController? {
    return transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
  }

  fileprivate func performSystemTransition(using context: UIViewControllerContextTransitioning) {
    CALayer.animate({
      let transition = CATransition()
      transition.type = systemTransitionType.rawValue
      transition.subtype = systemTransitionSubtype
      transition.duration = transitionDuration(using: context)
      transition.timingFunction = CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
      context.containerView.layer.add(transition, forKey: kCATransition)
    }, completion: {
      context.completeTransition(!context.transitionWasCancelled)
    })
  }
}

extension SystemTransitionAnimator: UIViewControllerAnimatedTransitioning {

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return transitionContext?.isAnimated == true ? transitionDuration : 0
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

    guard let toView = toView(using: transitionContext), fromView(using: transitionContext) != nil else {
      transitionContext.completeTransition(true)
      return
    }

    if let toViewController = toViewController(using: transitionContext) {
      toView.frame = transitionContext.finalFrame(for: toViewController)
    }

    transitionContext.containerView.addSubview(toView)

    performSystemTransition(using: transitionContext)

  }
}
