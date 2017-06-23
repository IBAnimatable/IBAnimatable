//
//  Created by Tom Baranes on 07/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class ContainerTransitionViewController: UIViewController, UITabBarDelegate {

  // MARK: Properties

  @IBOutlet fileprivate var tabBar: UITabBar!
  @IBOutlet fileprivate var containerView: UIView!

  fileprivate var viewControllers = [AnimatableViewController]()
  fileprivate var currentViewController: AnimatableViewController?

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    makeChildViewControllers()
    tabBar.selectedItem = tabBar.items?.first
  }

}

// MARK: - ChildViewController

private extension ContainerTransitionViewController {

  func makeChildViewControllers() {
    var viewController = AnimatableViewController()
    viewController.view.backgroundColor = .blue
    viewController.transitionAnimationType = .explode(xFactor: nil, minAngle: nil, maxAngle: nil)
    viewControllers.append(viewController)

    viewController = AnimatableViewController()
    viewController.view.backgroundColor = .green
    viewController.transitionAnimationType = .fold(from: .right, folds: nil)
    viewControllers.append(viewController)

    viewController = AnimatableViewController()
    viewController.view.backgroundColor = .yellow
    viewController.transitionAnimationType = .natGeo(to: .right)
    viewControllers.append(viewController)

    viewController = AnimatableViewController()
    viewController.view.backgroundColor = .red
    viewController.transitionAnimationType = .portal(direction: .backward, zoomScale: nil)
    viewControllers.append(viewController)

    cycleFromViewController(containerView, fromViewController: nil, toViewController: viewControllers[0])
  }

  func cycleFromViewController(_ containerView: UIView, fromViewController: AnimatableViewController?, toViewController: AnimatableViewController) {
    let transitionContext = ContainerTransition(animationType: toViewController.transitionAnimationType,
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

  @objc(tabBar:didSelectItem:)
  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    let toViewController = viewControllers[item.tag]
    cycleFromViewController(containerView, fromViewController: currentViewController, toViewController: toViewController)
  }

}
