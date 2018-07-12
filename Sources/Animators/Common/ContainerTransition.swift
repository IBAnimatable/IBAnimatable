//
//  Created by Tom Baranes on 06/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ContainerTransition: NSObject {

  public typealias ContainerTransitionCompletion = () -> Void

  // MARK: Properties

  public var animationType: TransitionAnimationType?
  public var transitionDuration: Duration = defaultTransitionDuration

  // MARK: Private

  fileprivate let container: UIView?
  fileprivate let parentViewController: UIViewController?
  fileprivate var viewControllers: [UITransitionContextViewControllerKey: UIViewController]?
  fileprivate var views: [UITransitionContextViewKey: UIView]?
  fileprivate let completion: ContainerTransitionCompletion?

  // MARK: Life cycle

  public init(animationType: TransitionAnimationType,
              container: UIView,
              parentViewController: UIViewController,
              fromViewController: UIViewController?,
              toViewController: UIViewController,
              completion: ContainerTransitionCompletion? = nil) {

    self.completion = completion
    self.animationType = animationType
    self.container = container
    self.parentViewController = parentViewController

    container.translatesAutoresizingMaskIntoConstraints = false
    toViewController.view.translatesAutoresizingMaskIntoConstraints = true
    toViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    toViewController.view.frame = container.bounds

    fromViewController?.willMove(toParent: nil)
    parentViewController.addChild(toViewController)

    guard let fromViewController = fromViewController else {
      container.addSubview(toViewController.view)
      toViewController.didMove(toParent: parentViewController)
      completion?()
      return
    }

    viewControllers = [UITransitionContextViewControllerKey.from: fromViewController,
                       UITransitionContextViewControllerKey.to: toViewController]
    views = [UITransitionContextViewKey.from: fromViewController.view,
             UITransitionContextViewKey.to: toViewController.view]
  }

  public func animate() {
    guard let animationType = animationType else {
      return
    }

    parentViewController?.view.isUserInteractionEnabled = false
    let animator = AnimatorFactory.makeAnimator(transitionAnimationType: animationType)
    animator?.transitionDuration = transitionDuration
    animator?.animateTransition(using: self)
  }

  public var isAnimated: Bool { return false }
  public var isInteractive: Bool { return false }
  public var presentationStyle: UIModalPresentationStyle { return .none }
  public var transitionWasCancelled: Bool { return false }
  public var targetTransform: CGAffineTransform { return .identity }
  public var containerView: UIView { return container! }
}

// MARK: - UIViewControllerContextTransitioning

extension ContainerTransition: UIViewControllerContextTransitioning {

  public func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
    return viewControllers?[key]
  }

  public func view(forKey key: UITransitionContextViewKey) -> UIView? {
    return views?[key]
  }

  public func completeTransition(_ didComplete: Bool) {
    viewControllers?[UITransitionContextViewControllerKey.from]?.view.removeFromSuperview()
    viewControllers?[UITransitionContextViewControllerKey.from]?.removeFromParent()
    viewControllers?[UITransitionContextViewControllerKey.to]?.didMove(toParent: parentViewController)
    parentViewController?.view.isUserInteractionEnabled = true
    completion?()
  }

  public func initialFrame(for vc: UIViewController) -> CGRect {
    return vc.view.frame
  }

  public func finalFrame(for vc: UIViewController) -> CGRect {
    return vc.view.frame
  }

  // MARK: Mandatory protocol

  public func updateInteractiveTransition(_ percentComplete: CGFloat) {}
  public func finishInteractiveTransition() {}
  public func cancelInteractiveTransition() {}
  public func pauseInteractiveTransition() {}

}
