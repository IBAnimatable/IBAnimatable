//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentationPresenter: NSObject {
  private var presentationAnimationType: PresentationAnimationType
  public var dismissalAnimationType: PresentationAnimationType?

  public var presentationConfiguration: PresentationConfiguration?
  public var transitionDuration: Duration {
    didSet {
      if oldValue != transitionDuration {
        updateTransitionDuration()
      }
    }
  }

  // animation controller
  fileprivate var animator: AnimatedPresenting?

  public init(presentationAnimationType: PresentationAnimationType, transitionDuration: Duration = defaultPresentationDuration) {
    self.presentationAnimationType = presentationAnimationType
    self.transitionDuration = transitionDuration
    super.init()

    updateTransitionDuration()
    if presentationAnimationType.systemTransition == nil {
      animator = AnimatorFactory.makeAnimator(presentationAnimationType: presentationAnimationType, transitionDuration: transitionDuration)
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
  public func presentationController(forPresented presented: UIViewController,
                                     presenting: UIViewController?,
                                     source: UIViewController) -> UIPresentationController? {
    guard let presentationConfiguration = presentationConfiguration else {
      return nil
    }
    return AnimatablePresentationController(presentedViewController: presented,
                                            presentingViewController: presenting,
                                            presentationConfiguration: presentationConfiguration)
  }

  // MARK: - animation controller
  public func animationController(forPresented presented: UIViewController,
                                  presenting: UIViewController,
                                  source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animator?.transitionDuration = transitionDuration
    return animator
  }

  public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let dismissalAnimationType = dismissalAnimationType else {
      return animator
    }

    if dismissalAnimationType.systemTransition != nil {
      return nil
    }
    return AnimatorFactory.makeAnimator(presentationAnimationType: dismissalAnimationType, transitionDuration: transitionDuration)
  }

}
