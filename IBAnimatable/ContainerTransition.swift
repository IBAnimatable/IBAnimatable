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
    
    viewControllers = [UITransitionContextFromViewControllerKey: unwrappedFromViewController,
                       UITransitionContextToViewControllerKey: toViewController]
    views = [UITransitionContextFromViewKey: unwrappedFromViewController.view,
             UITransitionContextToViewKey: toViewController.view]
  }
  
  public func animate() {
    guard let unwrappedAnimationType = animationType else {
      return
    }
    
    parentViewController?.view.isUserInteractionEnabled = false
    let animator = AnimatorFactory.generateAnimator(unwrappedAnimationType)
    animator.transitionDuration = transitionDuration
    animator.animateTransition(using: self)
  }
  public var isAnimated: Bool { return false }
  public var isInteractive: Bool { return false }
  public var presentationStyle: UIModalPresentationStyle { return .none }
  public var transitionWasCancelled: Bool { return false }
  public var targetTransform: CGAffineTransform { return CGAffineTransform.identity }
  public var containerView: UIView {return container!}
}

// MARK: - UIViewControllerContextTransitioning

extension ContainerTransition: UIViewControllerContextTransitioning {
  
 
  
  public func viewController(forKey key: String) -> UIViewController? {
    return viewControllers?[key]
  }
  
  public func view(forKey key: String) -> UIView? {
    return views?[key]
  }

  
  public func completeTransition(_ didComplete: Bool) {
    viewControllers?[UITransitionContextFromViewControllerKey]?.view.removeFromSuperview()
    viewControllers?[UITransitionContextFromViewControllerKey]?.removeFromParentViewController()
    viewControllers?[UITransitionContextToViewControllerKey]?.didMove(toParentViewController: parentViewController)
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
