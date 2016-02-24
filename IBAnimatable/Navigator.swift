//
// Created by Jake Lin on 2/24/16.
// Copyright (c) 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Custom navigator for `UINavigationController`
 */
public class Navigator: NSObject, UINavigationControllerDelegate {
  var transitionAnimationType: String?
  var transitionDuration: Duration

  public init(transitionAnimationType: String?, transitionDuration: Duration) {
    self.transitionAnimationType = transitionAnimationType
    self.transitionDuration = transitionDuration
  }

  public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let unwrappedTransitionAnimationType = transitionAnimationType, transitionAnimationType = TransitionAnimationType(rawValue: unwrappedTransitionAnimationType) else {
      return nil
    }

    if operation == .Push {
      return AnimatorFactory.generateAnimator(transitionAnimationType, transitionDuration: transitionDuration)
    } else if operation == .Pop {
      return AnimatorFactory.generateAnimator(transitionAnimationType, transitionDuration: transitionDuration)
    }
    return nil
  }
}
