//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Presenter for `UIViewController` to support custom transition animation for Present and Dismiss
 */
public class Presenter: NSObject {
  var transitionAnimationType: TransitionAnimationType
  var transitionDuration: Duration

  public init(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration) {
    self.transitionAnimationType = transitionAnimationType
    self.transitionDuration = transitionDuration
    super.init()
  }
}

extension Presenter: UIViewControllerTransitioningDelegate {
  public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = AnimatorFactory.generateAnimator(transitionAnimationType, transitionDuration: transitionDuration)
    return animator
  }

  public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = AnimatorFactory.generateAnimator(transitionAnimationType, transitionDuration: transitionDuration)
    // Use the reverse animation
    if let reverseTransitionAnimationType = animator.reverseAnimationType {
      return AnimatorFactory.generateAnimator(reverseTransitionAnimationType, transitionDuration: transitionDuration)
    }
    return nil
  }
}
