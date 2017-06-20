//
//  Created by Jake Lin on 5/13/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class TransitionPushedViewController: UIViewController {

  @IBOutlet fileprivate var gestureLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    if let animatableView = view as? AnimatableView {
      animatableView.predefinedGradient = makeRandomGradient()
    }
    configureGestureLabel()
  }
}

private extension TransitionPushedViewController {

  func configureGestureLabel() {
    // Shows nothing by default
    gestureLabel.text = "to pop"

    guard let navigationController = navigationController as? AnimatableNavigationController else {
      return
    }

    // No gesture for this animator
    if case .none = navigationController.interactiveGestureType {
      return
    }

    if case .none = navigationController.transitionAnimationType {
      return
    }

    gestureLabel.text = retrieveGestureText(interactiveGestureType: navigationController.interactiveGestureType,
                                            transitionAnimationType: navigationController.transitionAnimationType,
                                            exit: "pop")
  }

}
