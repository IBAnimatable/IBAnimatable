//
//  Created by Tom Baranes on 06/05/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

class ContainerTransition: NSObject, UIViewControllerContextTransitioning {
  
  typealias ContainerTransitionCompletion = () -> Void
  
  // MARK: Properties
  
  var animationType: TransitionAnimationType?
  var transitionDuration: Duration = defaultTransitionDuration
  
  // MARK: Private
  
  private let container: UIView?
  private let parentViewController: UIViewController?
  private var viewControllers: [String: UIViewController]? = nil
  private var views: [String: UIView]? = nil
  private let completion: ContainerTransitionCompletion?
  
  // MARK: Life cycle
  
  init(animationType: TransitionAnimationType,
       container: UIView, parentViewController: UIViewController,
       fromViewController: UIViewController?, toViewController: UIViewController,
       completion: ContainerTransitionCompletion? = nil) {
    
    self.completion = completion
    self.animationType = animationType
    self.container = container
    self.parentViewController = parentViewController
    
    container.translatesAutoresizingMaskIntoConstraints = false
    toViewController.view.translatesAutoresizingMaskIntoConstraints = true
    toViewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    toViewController.view.frame = container.bounds
    
    fromViewController?.willMoveToParentViewController(nil)
    parentViewController.addChildViewController(toViewController)
    
    guard let unwrappedFromViewController = fromViewController else {
      container.addSubview(toViewController.view)
      toViewController.didMoveToParentViewController(parentViewController)
      completion?()
      return
    }
    
    viewControllers = [UITransitionContextFromViewControllerKey: unwrappedFromViewController,
                       UITransitionContextToViewControllerKey: toViewController]
    views = [UITransitionContextFromViewKey: unwrappedFromViewController.view,
             UITransitionContextToViewKey: toViewController.view]
  }
  
  func animate() {
    guard let unwrappedAnimationType = animationType else {
      return
    }
    
    parentViewController?.view.userInteractionEnabled = false
    let animator = AnimatorFactory.generateAnimator(unwrappedAnimationType)
    animator.animateTransition(self)
  }
}

// MARK: - UIViewControllerContextTransitioning

extension ContainerTransition {
  
  func containerView() -> UIView? {
    return container
  }
  
  func viewControllerForKey(key: String) -> UIViewController? {
    return viewControllers?[key]
  }
  
  func viewForKey(key: String) -> UIView? {
    return views?[key]
  }
  
  func transitionWasCancelled() -> Bool {
    return false
  }
  
  func completeTransition(didComplete: Bool) {
    viewControllers?[UITransitionContextFromViewControllerKey]?.view.removeFromSuperview()
    viewControllers?[UITransitionContextFromViewControllerKey]?.removeFromParentViewController()
    viewControllers?[UITransitionContextToViewControllerKey]?.didMoveToParentViewController(parentViewController)
    parentViewController?.view.userInteractionEnabled = true
    completion?()
  }
  
  
  // MARK: Mandatory protocol
  
  func initialFrameForViewController(vc: UIViewController) -> CGRect { return CGRect.zero }
  func finalFrameForViewController(vc: UIViewController) -> CGRect { return CGRect.zero}
  func isAnimated() -> Bool { return false }
  func isInteractive() -> Bool { return false }
  func presentationStyle() -> UIModalPresentationStyle { return .None }
  func targetTransform() -> CGAffineTransform { return CGAffineTransformIdentity }
  func updateInteractiveTransition(percentComplete: CGFloat) {}
  func finishInteractiveTransition() {}
  func cancelInteractiveTransition() {}
  
}
