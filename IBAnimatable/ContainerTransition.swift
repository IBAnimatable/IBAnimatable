//
//  Created by Tom Baranes on 06/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class ContainerTransition: NSObject {
  
  public typealias ContainerTransitionCompletion = () -> Void
  
  // MARK: Properties
  
  open var animationType: TransitionAnimationType?
  open var transitionDuration: Duration = defaultTransitionDuration
  
  // MARK: Private
  
  fileprivate let container: UIView?
  fileprivate let parentViewController: UIViewController?
  fileprivate var viewControllers: [String: UIViewController]? = nil
  fileprivate var views: [String: UIView]? = nil
  fileprivate let completion: ContainerTransitionCompletion?
  
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
    toViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    toViewController.view.frame = container.bounds
    
    fromViewController?.willMove(toParentViewController: nil)
    parentViewController.addChildViewController(toViewController)
    
    guard let unwrappedFromViewController = fromViewController else {
      container.addSubview(toViewController.view)
      toViewController.didMove(toParentViewController: parentViewController)
      completion?()
      return
    }
    
    viewControllers = [UITransitionContextViewControllerKey.from.rawValue: unwrappedFromViewController,
                       UITransitionContextViewControllerKey.to.rawValue: toViewController]
    views = [UITransitionContextViewKey.from.rawValue: unwrappedFromViewController.view,
             UITransitionContextViewKey.to.rawValue: toViewController.view]
  }
  
  open func animate() {
    guard let unwrappedAnimationType = animationType else {
      return
    }
    
    parentViewController?.view.isUserInteractionEnabled = false
    let animator = AnimatorFactory.generateAnimator(unwrappedAnimationType)
    animator.transitionDuration = transitionDuration
    animator.animateTransition(using: self)
  }
  open var isAnimated: Bool { return false }
  open var isInteractive: Bool { return false }
  open var presentationStyle: UIModalPresentationStyle { return .none }
  open var transitionWasCancelled: Bool { return false }
  open var targetTransform: CGAffineTransform { return CGAffineTransform.identity }
  open var containerView: UIView {return container!}
}

// MARK: - UIViewControllerContextTransitioning

extension ContainerTransition: UIViewControllerContextTransitioning {
  
 
  
  public func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
    return viewControllers?[key.rawValue]
  }
  
  public func view(forKey key: UITransitionContextViewKey) -> UIView? {
    return views?[key.rawValue]
  }

  
  public func completeTransition(_ didComplete: Bool) {
    viewControllers?[UITransitionContextViewControllerKey.from.rawValue]?.view.removeFromSuperview()
    viewControllers?[UITransitionContextViewControllerKey.from.rawValue]?.removeFromParentViewController()
    viewControllers?[UITransitionContextViewControllerKey.to.rawValue]?.didMove(toParentViewController: parentViewController)
    parentViewController?.view.isUserInteractionEnabled = true
    completion?()
  }
  
  
  // MARK: Mandatory protocol
  
  public func initialFrame(for vc: UIViewController) -> CGRect { return CGRect.zero }
  public func finalFrame(for vc: UIViewController) -> CGRect { return CGRect.zero}
  public func updateInteractiveTransition(_ percentComplete: CGFloat) {}
  public func finishInteractiveTransition() {}
  public func cancelInteractiveTransition() {}
  public func pauseInteractiveTransition() {
  }
  
}
