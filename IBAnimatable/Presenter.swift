//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Presenter for `UIViewController` to support custom transition animation for Present and Dismiss
 */
public class Presenter: NSObject {
  private var transitionAnimationType: TransitionAnimationType
  var transitionDuration: Duration {
    didSet {
      if oldValue != transitionDuration {
        updateTransitionDuration()
      }
    }
  }
  
  var interactiveGestureType: InteractiveGestureType? {
    // Update `interactiveAnimator` if needed
    didSet {
      if oldValue != interactiveGestureType {
        updateInteractiveAnimator()
      }
    }
  }
  
  // animation controller
  private var animator: AnimatedTransitioning?
  
  // interaction controller
  private var interactiveAnimator: PanInteractiveAnimator?
  
  public init(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration = defaultTransitionDuration, interactiveGestureType: InteractiveGestureType? = nil) {
    self.transitionAnimationType = transitionAnimationType
    self.transitionDuration = transitionDuration
    super.init()
    
    updateTransitionDuration()
    
    animator = AnimatorFactory.generateAnimator(transitionAnimationType, transitionDuration: transitionDuration)
    
    self.interactiveGestureType = interactiveGestureType
    updateInteractiveAnimator()
  }
  
  // MARK: - Private
  private func updateTransitionDuration() {
    if transitionDuration.isNaN {
      transitionDuration = defaultTransitionDuration
    }
  }
  
  private func updateInteractiveAnimator() {
    // If interactiveGestureType has been set
    if let interactiveGestureType = interactiveGestureType {
      // If configured as `.Default` then use the default interactive gesture type from the Animator
      if interactiveGestureType == .Default {
        if let interactiveGestureType = animator?.interactiveGestureType {
          interactiveAnimator = PanInteractiveAnimator(interactiveGestureType: interactiveGestureType, transitionType: .PresentationTransition(.Dismissal))
        }
      } else {
        interactiveAnimator = PanInteractiveAnimator(interactiveGestureType: interactiveGestureType, transitionType: .PresentationTransition(.Dismissal))
      }
    }
    else {
      interactiveAnimator = nil
    }
  }
}

extension Presenter: UIViewControllerTransitioningDelegate {
  // MARK: - animation controller
  public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animator?.transitionDuration = transitionDuration
    interactiveAnimator?.connectGestureRecognizer(presented)
    return animator
  }

  public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    // Use the reverse animation
    if let reverseTransitionAnimationType = animator?.reverseAnimationType {
      return AnimatorFactory.generateAnimator(reverseTransitionAnimationType, transitionDuration: transitionDuration)
    }
    return nil
  }
  
  // MARK: - interaction controller
  public func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    if let interactiveAnimator = interactiveAnimator where interactiveAnimator.interacting {
      return interactiveAnimator
    } else {
      return nil
    }
  }
}
