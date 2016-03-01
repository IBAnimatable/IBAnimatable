//
//  Created by Jake Lin on 3/1/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

class TransitionViewController: AnimatableViewController {
  @IBAction func presentButtonDidTap(sender: AnyObject) {
    guard let toViewController = storyboard?.instantiateViewControllerWithIdentifier("PresentedFirstViewController") as? AnimatableViewController else {
      return
    }
    
    toViewController.transitionAnimationType = String(TransitionAnimationType.FadeIn)
    let segue = PresentFadeSegue(identifier: String(PresentFadeSegue), source: self, destination: toViewController)
    prepareForSegue(segue, sender: self)
    segue.perform()
  }
}
