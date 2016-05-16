//
//  Created by Jake Lin on 5/16/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class TransitionPresentedViewController: AnimatableViewController {

  @IBOutlet var gestureLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let animatableView = view as? AnimatableView {
      animatableView.predefinedGradient = String(generateRandomGradient())
    }
    configureGestureLabel()
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

private extension TransitionPresentedViewController {
  
  func configureGestureLabel() {
    // Shows nothing by default
    gestureLabel.text = ""
    
    // No gesture for this animator
    guard let interactiveGestureTypeString = interactiveGestureType,
      interactiveGestureType = InteractiveGestureType.fromString(interactiveGestureTypeString),
      transitionAnimationTypeString = transitionAnimationType,
      transitionAnimationType = TransitionAnimationType.fromString(transitionAnimationTypeString) else {
        return
    }
    
    gestureLabel.text = retrieveGestureText(interactiveGestureType, transitionAnimationType: transitionAnimationType, exit: "dismiss")
  }
  
}
