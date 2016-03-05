//
// Created by Jake Lin on 2/24/16.
// Copyright (c) 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Navigator for `UINavigationController` to support custom transition animation for Push and Pop
 */
public class Navigator: NSObject {
  var transitionAnimationType: TransitionAnimationType
  var transitionDuration: Duration = defaultTransitionDuration
  
  // Used for interactionController
  private var interactiveAnimator: PanInteractiveAnimator = PanInteractiveAnimator(gestureFromDirection: .FromLeft)
  
  public init(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration = defaultTransitionDuration) {
    self.transitionAnimationType = transitionAnimationType
    self.transitionDuration = transitionDuration
    super.init()
  }
}

extension Navigator: UINavigationControllerDelegate {
  public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = AnimatorFactory.generateAnimator(transitionAnimationType, transitionDuration: transitionDuration)
    if operation == .Push {
      interactiveAnimator.connectGestureRecognizer(toVC)
      return animator
    } else if operation == .Pop {
      interactiveAnimator.connectGestureRecognizer(toVC)
      // Use the reverse animation
      if let reverseTransitionAnimationType = animator.reverseAnimationType {
        return AnimatorFactory.generateAnimator(reverseTransitionAnimationType, transitionDuration: transitionDuration)
      }
    }
    return nil
  }
  
  public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    if interactiveAnimator.interacting {
      return interactiveAnimator
    } else {
      return nil
    }
  }
}
