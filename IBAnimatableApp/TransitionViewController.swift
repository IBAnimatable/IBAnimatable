//
//  Created by Jake Lin on 3/1/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class TransitionViewController: AnimatableViewController {
  
  @IBOutlet var presentButton: AnimatableButton!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Transition animations start with `System` do not support Present transition, so hide it
    if let animationType = transitionAnimationType where animationType.hasPrefix("System") {
      // Cannot use `hidden` here because of `UIStackView`
      presentButton.alpha = 0
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    // Set the transition animation type for `AnimatableViewController`, used for Present/Dismiss transitions
    if let toViewController = segue.destinationViewController as? AnimatableViewController {
      toViewController.transitionAnimationType = transitionAnimationType
      toViewController.interactiveGestureType = interactiveGestureType
    }
  }
}
