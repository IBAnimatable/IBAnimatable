//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

/**
 TransitionPresenter for `UIViewController` to support custom transition animation for Present and Dismiss
 */
public class TransitionPresenter: NSObject {
  fileprivate var transitionAnimationType: TransitionAnimationType
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
      if oldValue?.stringValue != interactiveGestureType?.stringValue {
        updateInteractiveAnimator()
      }
    }
  }
  
  // animation controller
  fileprivate var animator: AnimatedTransitioning?
  
  // interaction controller
  fileprivate var interactiveAnimator: InteractiveAnimator?
  
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
  fileprivate func updateTransitionDuration() {
    if transitionDuration.isNaN {
      transitionDuration = defaultTransitionDuration
    }
  }
  
  fileprivate func updateInteractiveAnimator() {
    // If interactiveGestureType has been set
    if let interactiveGestureType = interactiveGestureType {
      // If configured as `.Default` then use the default interactive gesture type from the Animator
      switch interactiveGestureType {
      case .default:
        if let interactiveGestureType = animator?.interactiveGestureType {
          interactiveAnimator = InteractiveAnimatorFactory.generateInteractiveAnimator(interactiveGestureType, transitionType: .presentationTransition(.dismissal))
        }
      default:
        interactiveAnimator = InteractiveAnimatorFactory.generateInteractiveAnimator(interactiveGestureType, transitionType: .presentationTransition(.dismissal))
      }
    } else {
      interactiveAnimator = nil
    }
  }
}

extension TransitionPresenter: UIViewControllerTransitioningDelegate {

  // MARK: - animation controller
  public func animationController(forPresentedController presented: UIViewController, presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animator?.transitionDuration = transitionDuration
    interactiveAnimator?.connectGestureRecognizer(presented)
    return animator
  }

  public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    // Use the reverse animation
    if let reverseTransitionAnimationType = animator?.reverseAnimationType {
      return AnimatorFactory.generateAnimator(reverseTransitionAnimationType, transitionDuration: transitionDuration)
    }
    return nil
  }
  
  // MARK: - interaction controller
  public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    if let interactiveAnimator = interactiveAnimator, interactiveAnimator.interacting {
      return interactiveAnimator
    } else {
      return nil
    }
  }
}
