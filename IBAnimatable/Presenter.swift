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
  var transitionDuration: Duration = defaultTransitionDuration

  // animation controller
  private var animator: AnimatedTransitioning?
  
  // interaction controller
  private var interactiveAnimator: PanInteractiveAnimator?
  
  public init(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration = defaultTransitionDuration, interactiveGestureType: InteractiveGestureType? = nil) {
    self.transitionAnimationType = transitionAnimationType
    self.transitionDuration = transitionDuration
    super.init()
    
    animator = AnimatorFactory.generateAnimator(transitionAnimationType, transitionDuration: transitionDuration)
    
    // If interactiveGestureType has been set
    if let interactiveGestureType = interactiveGestureType {
      // If configured as `.Default` then use the default interactive gesture type from the Animator
      if interactiveGestureType == .Default {
        if let interactiveGestureType = animator?.interactiveGestureType {
          interactiveAnimator = PanInteractiveAnimator(interactiveGestureType: interactiveGestureType)
        }
      } else {
        interactiveAnimator = PanInteractiveAnimator(interactiveGestureType: interactiveGestureType)
      }
    }
  }
}

extension Presenter: UIViewControllerTransitioningDelegate {
  public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animator?.transitionDuration = transitionDuration
    return animator
  }

  public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    // Use the reverse animation
    if let reverseTransitionAnimationType = animator?.reverseAnimationType {
      return AnimatorFactory.generateAnimator(reverseTransitionAnimationType, transitionDuration: transitionDuration)
    }
    return nil
  }
}
