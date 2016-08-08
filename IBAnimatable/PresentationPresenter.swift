//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentationPresenter: NSObject {
  private var presentationAnimationType: PresentationAnimationType
  var dismissalAnimationType: PresentationAnimationType?

  var presentationConfiguration: PresentationConfiguration?
  var transitionDuration: Duration {
    didSet {
      if oldValue != transitionDuration {
        updateTransitionDuration()
      }
    }
  }

  // animation controller
  private var animator: AnimatedPresenting?

  public init(presentationAnimationType: PresentationAnimationType, transitionDuration: Duration = defaultPresentationDuration) {
    self.presentationAnimationType = presentationAnimationType
    self.transitionDuration = transitionDuration
    super.init()

    updateTransitionDuration()
    if presentationAnimationType.systemTransition == nil {
      animator = AnimatorFactory.generateAnimator(presentationAnimationType, transitionDuration: transitionDuration)
    }
  }

  // MARK: - Private
  private func updateTransitionDuration() {
    if transitionDuration.isNaN {
      transitionDuration = defaultPresentationDuration
    }
  }
}

extension PresentationPresenter: UIViewControllerTransitioningDelegate {

  // MARK: - presentation
  public func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController?, sourceViewController source: UIViewController) -> UIPresentationController? {
    guard let unwrappedPresentationConfiguration = presentationConfiguration else {
      return nil
    }
    guard let unwrappedPresentingViewController = presenting else{
      return nil
    }
    return AnimatablePresentationController(presentedViewController: presented, presentingViewController: unwrappedPresentingViewController, presentationConfiguration: unwrappedPresentationConfiguration)
  }

  // MARK: - animation controller
  public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animator?.transitionDuration = transitionDuration
    return animator
  }

  public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let dismissalAnimationType = dismissalAnimationType else {
      return animator
    }

    if dismissalAnimationType.systemTransition != nil {
      return nil
    }
    return AnimatorFactory.generateAnimator(dismissalAnimationType, transitionDuration: transitionDuration)
  }

}
