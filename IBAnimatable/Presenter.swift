//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Presenter for `UIViewController` to support custom transition animation for Present and Dismiss
 */
public class Presenter: NSObject {
  var transitionAnimationType: String?
  var transitionDuration: Duration

  public init(transitionAnimationType: String?, transitionDuration: Duration) {
    self.transitionAnimationType = transitionAnimationType
    self.transitionDuration = transitionDuration
    super.init()
  }
}

extension Presenter: UIViewControllerTransitioningDelegate {
  public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let unwrappedTransitionAnimationType = transitionAnimationType, transitionAnimationType = TransitionAnimationType(rawValue: unwrappedTransitionAnimationType) else {
      return nil
    }

    let animator = AnimatorFactory.generateAnimator(transitionAnimationType, transitionDuration: transitionDuration)
    return animator
  }

  public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let unwrappedTransitionAnimationType = transitionAnimationType, transitionAnimationType = TransitionAnimationType(rawValue: unwrappedTransitionAnimationType) else {
      return nil
    }

    let animator = AnimatorFactory.generateAnimator(transitionAnimationType, transitionDuration: transitionDuration)
    // Use the reverse animation
    if let reverseAnimationType = animator.reverseAnimationType, reverseTransitionAnimationType = TransitionAnimationType(rawValue: reverseAnimationType) {
      return AnimatorFactory.generateAnimator(reverseTransitionAnimationType, transitionDuration: transitionDuration)
    }
    return nil
  }
}
