//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentationPresenter: NSObject {
  private var presentationAnimationType: PresentationAnimationType
  var dismissAnimationType: PresentationAnimationType?

  var presentedSetup: PresentedSetup?
  var transitionDuration: Duration {
    didSet {
      if oldValue != transitionDuration {
        updateTransitionDuration()
      }
    }
  }

  // animation controller
  private var animator: AnimatedPresenting?

  public init(presentationAnimationType: PresentationAnimationType, transitionDuration: Duration = defaultTransitionDuration) {
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
      transitionDuration = defaultTransitionDuration
    }
  }
}

extension PresentationPresenter: UIViewControllerTransitioningDelegate {

  // MARK: - presentation
  public func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
    guard let unwrappedPresenterSetup = presentedSetup else {
      return nil
    }
    return PresentationAnimatable(presentedViewController: presented, presentingViewController: presenting, presentedSetup: unwrappedPresenterSetup)
  }

  // MARK: - animation controller
  public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animator?.transitionDuration = transitionDuration
    return animator
  }

  public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let dismissAnimationType = dismissAnimationType else {
      return animator
    }

    if dismissAnimationType.systemTransition != nil {
      return nil
    }
    return AnimatorFactory.generateAnimator(dismissAnimationType, transitionDuration: transitionDuration)
  }

}
