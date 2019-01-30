//
//  Created by phimage on 11/04/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit

open class AnimatableTabBarController: UITabBarController, TransitionAnimatable {

  // MARK: - TransitionAnimatable
  @IBInspectable  var _transitionAnimationType: String? {
    didSet {
      if let _transitionAnimationType = _transitionAnimationType {
        transitionAnimationType = TransitionAnimationType(string: _transitionAnimationType)
      }
    }
  }
  open var transitionAnimationType: TransitionAnimationType = .none {
    didSet {
      configureNavigationControllerDelegate()
    }
  }
  @IBInspectable open var transitionDuration: Double = .nan {
    didSet {
      configureNavigationControllerDelegate()
    }
  }
  open var interactiveGestureType: InteractiveGestureType = .none {
    didSet {
      configureNavigationControllerDelegate()
    }
  }

  @IBInspectable var _interactiveGestureType: String? {
    didSet {
      if let _interactiveGestureType = _interactiveGestureType {
        interactiveGestureType = InteractiveGestureType(string: _interactiveGestureType)
      }
    }
  }

  // MARK: - UITabBarDelegate
  open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    guard let animatable = item as? (UITabBarItem & Animatable),
      let tabBarButton = tabBar.view(for: item) else {
        return
    }
    // Animate the children image view
    if let imageView = tabBarButton.subviews.first(where: { $0 is UIImageView }) {
      animatable.animate(view: imageView)
    }
  }

  // MARK: - Private
  // Must have a property to keep the reference alive because `UITabBarController.delegate` is `weak`
  fileprivate var navigator: Navigator?

  fileprivate func configureNavigationControllerDelegate() {
    if case .none = transitionAnimationType {
      navigator = nil
      delegate = nil
      return
    }
    var duration = transitionDuration
    // Set the default duration for transition
    if transitionDuration.isNaN {
      duration = defaultTransitionDuration
    }

    if case .none = interactiveGestureType {
      navigator = Navigator(transitionAnimationType: transitionAnimationType, transitionDuration: duration)
    } else {
      navigator = Navigator(transitionAnimationType: transitionAnimationType,
                            transitionDuration: duration,
                            interactiveGestureType: interactiveGestureType)
    }
    delegate = navigator
  }
}

private extension UITabBar {

    func view(for item: UITabBarItem) -> UIControl? {
      // return item.value(forKeyPath: "view") as? UIControl // apple could not allow that
      #if swift(>=4.2)
      guard let items = self.items,
        let index = items.firstIndex(of: item) else {
          return nil
      }

      #else
      guard let items = self.items,
        let index = items.index(of: item) else {
        return nil
      }

      #endif

      // get all buttons
      // 1/ filter on control, not safe if apple add a new control in bar
      let controls = self.subviews.filter { $0 is UIControl }
      // 2/ filter on name, not safe if button class change
      // let controls = self.subviews.filter { String(describing: type(of: $0 )) == "UITabBarButton" }

      guard index < controls.count else {
        // item could be not in tab bar (see "More")
        return nil
      }
      return controls[index] as? UIControl
    }

}
