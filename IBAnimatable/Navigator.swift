//
// Created by Jake Lin on 2/24/16.
// Copyright (c) 2016 IBAnimatable. All rights reserved.
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
      case .Default:
        if let interactiveGestureType = animator?.interactiveGestureType {
          interactiveAnimator = InteractiveAnimatorFactory.generateInteractiveAnimator(interactiveGestureType, transitionType: .NavigationTransition(.Pop))
        }
      default:
        interactiveAnimator = InteractiveAnimatorFactory.generateInteractiveAnimator(interactiveGestureType, transitionType: .NavigationTransition(.Pop))
      }
    }
  }
}

extension Navigator: UINavigationControllerDelegate {
  // MARK: - animation controller
  public func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    interactiveAnimator?.connectGestureRecognizer(toVC)
    
    if operation == .Push {
      animator?.transitionDuration = transitionDuration
      return animator
    } else if operation == .Pop {
      // Use the reverse animation
      if let reverseTransitionAnimationType = animator?.reverseAnimationType {
        return AnimatorFactory.generateAnimator(reverseTransitionAnimationType, transitionDuration: transitionDuration)
      }
    }
    return nil
  }
  
  // MARK: - interaction controller
  public func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    if let interactiveAnimator = interactiveAnimator where interactiveAnimator.interacting {
      return interactiveAnimator
    } else {
      return nil
    }
  }
}
