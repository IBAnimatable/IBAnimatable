//
//  Created by Jake Lin on 3/1/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class TransitionViewController: AnimatableViewController {

  @IBOutlet fileprivate var presentButton: AnimatableButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Transition animations start with `System` do not support Present transition, so hide it
    if transitionAnimationType.stringValue.hasPrefix("system") {
      // Cannot use `hidden` here because of `UIStackView`
      presentButton.alpha = 0
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    // Set the transition animation type for `AnimatableViewController`, used for Present/Dismiss transitions
    if let toViewController = segue.destination as? AnimatableViewController {
      toViewController.transitionAnimationType = transitionAnimationType
      toViewController.interactiveGestureType = interactiveGestureType
    }
  }
}
