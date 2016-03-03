//
//  Created by Jake Lin on 3/1/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

class TransitionViewController: AnimatableViewController {
  var animationType: String?
  
    @IBOutlet var presentButton: AnimatableButton!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Transition animations start with `System` do not support Present transition, so hide it
    if let animationType = animationType where animationType.hasPrefix("System") {
        presentButton.alpha = 0
    }
  }
  
  @IBAction func presentButtonDidTap(sender: AnyObject) {
    guard let toViewController = storyboard?.instantiateViewControllerWithIdentifier("PresentedFirstViewController") as? AnimatableViewController, animationType = animationType else {
      return
    }
    
    toViewController.transitionAnimationType = animationType
    let segueName = "IBAnimatable.Present" + animationType + "Segue"
    guard let segueClass = NSClassFromString(segueName) as? UIStoryboardSegue.Type else {
      return
    }
    
    let segue = segueClass.init(identifier: String(PresentFadeSegue), source: self, destination: toViewController)
    prepareForSegue(segue, sender: self)
    segue.perform()
  }
}
