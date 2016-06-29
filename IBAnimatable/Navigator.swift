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
  
  // animation controller
  private var animator: AnimatedTransitioning?
  // interaction controller
  private var interactiveAnimator: InteractiveAnimator?
  
  public init(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration = defaultTransitionDuration, interactiveGestureType: InteractiveGestureType? = nil) {
    self.transitionAnimationType = transitionAnimationType
    self.transitionDuration = transitionDuration
    super.init()
    
    animator = AnimatorFactory.generateAnimator(transitionAnimationType, transitionDuration: transitionDuration)
    
    // If interactiveGestureType has been set
    if let interactiveGestureType = interactiveGestureType {
      // If configured as `.Default` then use the default interactive gesture type from the Animator
      switch interactiveGestureType {
      case .default:
        if let interactiveGestureType = animator?.interactiveGestureType {
          interactiveAnimator = InteractiveAnimatorFactory.generateInteractiveAnimator(interactiveGestureType, transitionType: .navigationTransition(.pop))
        }
      default:
        interactiveAnimator = InteractiveAnimatorFactory.generateInteractiveAnimator(interactiveGestureType, transitionType: .navigationTransition(.pop))
      }
    }
  }
}

extension Navigator: UINavigationControllerDelegate {
  // MARK: - animation controller
  public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    interactiveAnimator?.connectGestureRecognizer(toVC)
    
    if operation == .push {
      animator?.transitionDuration = transitionDuration
      return animator
    } else if operation == .pop {
      // Use the reverse animation
      if let reverseTransitionAnimationType = animator?.reverseAnimationType {
        return AnimatorFactory.generateAnimator(reverseTransitionAnimationType, transitionDuration: transitionDuration)
      }
    }
    return nil
  }
  
  // MARK: - interaction controller
  public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    if let interactiveAnimator = interactiveAnimator where interactiveAnimator.interacting {
      return interactiveAnimator
    } else {
      return nil
    }
  }
}
