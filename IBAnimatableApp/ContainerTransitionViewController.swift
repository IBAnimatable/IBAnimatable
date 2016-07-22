//
//  Created by Tom Baranes on 07/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

class ContainerTransitionViewController: UIViewController, UITabBarDelegate {

  // MARK: Properties
  
  @IBOutlet var tabBar: UITabBar!
  @IBOutlet var containerView: UIView!
  
  private var viewControllers = [AnimatableViewController]()
  private var currentViewController: AnimatableViewController?
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createChildViewControllers()
    tabBar.selectedItem = tabBar.items?.first
  }
  
}

// MARK: - ChildViewController

private extension ContainerTransitionViewController {
  
  func createChildViewControllers() {
    var viewController = AnimatableViewController()
    viewController.view.backgroundColor = .blue()
    viewController.transitionAnimationType = "Explode"
    viewControllers.append(viewController)
   
    viewController = AnimatableViewController()
    viewController.view.backgroundColor = .green()
    viewController.transitionAnimationType = "Fold"
    viewControllers.append(viewController)

    viewController = AnimatableViewController()
    viewController.view.backgroundColor = .yellow()
    viewController.transitionAnimationType = "NatGeo"
    viewControllers.append(viewController)
    
    viewController = AnimatableViewController()
    viewController.view.backgroundColor = .red()
    viewController.transitionAnimationType = "Portal"
    viewControllers.append(viewController)
    
    cycleFromViewController(containerView, fromViewController: nil, toViewController: viewControllers[0])

  }
  
  func cycleFromViewController(_ containerView: UIView, fromViewController: AnimatableViewController?, toViewController: AnimatableViewController) {
    guard let animationType = TransitionAnimationType.fromString(toViewController.transitionAnimationType ?? "") else {
      return
    }
    
    let transitionContext = ContainerTransition(animationType: animationType,
                                                container: containerView,
                                                parentViewController: self,
                                                fromViewController: fromViewController,
                                                toViewController: toViewController) {
      self.currentViewController = toViewController
    }
    transitionContext.animate()
  }
  
}

// MARK: - UITabBarDelegate

extension ContainerTransitionViewController {

  @objc(tabBar:didSelectItem:) func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    let toViewController = viewControllers[item.tag]
    cycleFromViewController(containerView, fromViewController: currentViewController, toViewController: toViewController)
  }
  
}
