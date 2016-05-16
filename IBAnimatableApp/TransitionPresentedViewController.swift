//
//  Created by Jake Lin on 5/16/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class TransitionPresentedViewController: AnimatableViewController {

  @IBOutlet var gestureLabel: UILabel!
  
  // Intenal use for demo only
  var useDismissInteraction: Bool = false
  
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

  @IBAction func presentViaSegueDidTap(sender: AnyObject) {
    presentViaSegue(false)
  }
  
  @IBAction func presentViaDismissInteractionSegueDidTap(sender: AnyObject) {
    presentViaSegue(true)
  }
}

private extension TransitionPresentedViewController {
  
  func configureGestureLabel() {
    // Shows nothing by default
    gestureLabel.text = ""
    
    // If `useDismissInteraction` is `false` then don't support gesture interaction
    guard useDismissInteraction else {
      return
    }
    
    // No gesture for this animator
    guard let interactiveGestureTypeString = interactiveGestureType,
      interactiveGestureType = InteractiveGestureType.fromString(interactiveGestureTypeString),
      transitionAnimationTypeString = transitionAnimationType,
      transitionAnimationType = TransitionAnimationType.fromString(transitionAnimationTypeString) else {
        return
    }
    
    gestureLabel.text = retrieveGestureText(interactiveGestureType, transitionAnimationType: transitionAnimationType, exit: "dismiss")
  }
  
  // To extract the type without parameters
  func extractAnimationType(animationType: String) -> String {
    if let range = animationType.rangeOfString("(") {
      return animationType.substringToIndex(range.startIndex)
    }
    return animationType
  }
  
  func presentViaSegue(useDismissInteraction: Bool) {
    guard let toViewController = storyboard?.instantiateViewControllerWithIdentifier("TransitionPresentedViewController") as? TransitionPresentedViewController, transitionAnimationType = transitionAnimationType else {
      return
    }
    
    toViewController.useDismissInteraction = useDismissInteraction
    let seguePostfix = useDismissInteraction ? "WithDismissInteractionSegue": "Segue"
    let segueName = "IBAnimatable.Present" + extractAnimationType(transitionAnimationType) + seguePostfix
    guard let segueClass = NSClassFromString(segueName) as? UIStoryboardSegue.Type else {
      return
    }
    
    let segue = segueClass.init(identifier: segueName, source: self, destination: toViewController)
    prepareForSegue(segue, sender: self)
    segue.perform()
  }
  
}
