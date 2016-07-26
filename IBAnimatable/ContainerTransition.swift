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
  
  private let container: UIView?
  private let parentViewController: UIViewController?
  private var viewControllers: [String: UIViewController]? = nil
  private var views: [String: UIView]? = nil
  private let completion: ContainerTransitionCompletion?
  
  // MARK: Life cycle
  
  public init(animationType: TransitionAnimationType,
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
  
  public func animate() {
    guard let unwrappedAnimationType = animationType else {
      return
    }
    
    parentViewController?.view.userInteractionEnabled = false
    let animator = AnimatorFactory.generateAnimator(unwrappedAnimationType)
    animator.transitionDuration = transitionDuration
    animator.animateTransition(self)
  }
}

// MARK: - UIViewControllerContextTransitioning

extension ContainerTransition: UIViewControllerContextTransitioning {
  
  public func containerView() -> UIView? {
    return container
  }
  
  public func viewControllerForKey(key: String) -> UIViewController? {
    return viewControllers?[key]
  }
  
  public func viewForKey(key: String) -> UIView? {
    return views?[key]
  }
  
  public func transitionWasCancelled() -> Bool {
    return false
  }
  
  public func completeTransition(didComplete: Bool) {
    viewControllers?[UITransitionContextFromViewControllerKey]?.view.removeFromSuperview()
    viewControllers?[UITransitionContextFromViewControllerKey]?.removeFromParentViewController()
    viewControllers?[UITransitionContextToViewControllerKey]?.didMoveToParentViewController(parentViewController)
    parentViewController?.view.userInteractionEnabled = true
    completion?()
  }
  
  
  // MARK: Mandatory protocol
  
  public func initialFrameForViewController(vc: UIViewController) -> CGRect { return CGRect.zero }
  public func finalFrameForViewController(vc: UIViewController) -> CGRect { return CGRect.zero}
  public func isAnimated() -> Bool { return false }
  public func isInteractive() -> Bool { return false }
  public func presentationStyle() -> UIModalPresentationStyle { return .None }
  public func targetTransform() -> CGAffineTransform { return CGAffineTransformIdentity }
  public func updateInteractiveTransition(percentComplete: CGFloat) {}
  public func finishInteractiveTransition() {}
  public func cancelInteractiveTransition() {}
  
}
