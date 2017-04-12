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

  init(systemType: TransitionAnimationType.SystemTransitionType, duration: Duration) {

    systemTransitionType = systemType
    transitionDuration = duration
    transitionAnimationType = TransitionAnimationType(systemType: systemType)
    reverseAnimationType = transitionAnimationType.reversed
    systemTransitionSubtype = systemType == .rotate ? "90" : nil

    super.init()
  }

  init(systemType: TransitionAnimationType.SystemTransitionType, duration: Duration, direction: TransitionAnimationType.Direction) {

    transitionAnimationType = TransitionAnimationType(systemType: systemType, direction: direction)
    reverseAnimationType = transitionAnimationType.reversed
    transitionDuration = duration
    systemTransitionType = systemType

    switch systemType {
    case .cube, .flip, .moveIn, .push, .reveal:
      systemTransitionSubtype = direction.caTransitionSubtype
      interactiveGestureType = .pan(from: direction.opposingGesture)
    case .cameraIrisHollowClose, .cameraIrisHollowOpen, .cameraIris:
      interactiveGestureType = .pinch(direction: direction.opposingGesture)
    case .pageUnCurl, .pageCurl:
      interactiveGestureType = .pan(from: direction.opposingGesture)
    default:
      fatalError("Should never be executed: use other SystemTranitionAnimator.init")
    }

    super.init()
  }

  // MARK: - Helper Methods (Private)
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

    let toViewTemp = transitionContext.view(forKey: UITransitionContextViewKey.to)
    let fromViewTemp = transitionContext.view(forKey: UITransitionContextViewKey.from)
    let toViewControllerTemp = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)

    guard let toView = toViewTemp, fromViewTemp != nil else {
      transitionContext.completeTransition(true)
      return
    }

    if let toViewController = toViewControllerTemp {
      toView.frame = transitionContext.finalFrame(for: toViewController)
    }

    transitionContext.containerView.addSubview(toView)

    performSystemTransition(using: transitionContext)

  }

}
