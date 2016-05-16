//
//  Created by Jake Lin on 5/16/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class TransitionPresentedViewController: AnimatableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let animatableView = view as? AnimatableView {
      animatableView.predefinedGradient = String(generateRandomGradient())
    }
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    // Set the transition animation type for `AnimatableViewController`, used for Present/Dismiss transitions
    if let toViewController = segue.destinationViewController as? AnimatableViewController {
      toViewController.transitionAnimationType = transitionAnimationType
    }
  }
}
