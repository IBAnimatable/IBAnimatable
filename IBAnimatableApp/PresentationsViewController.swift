//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class PresentationsViewController: AnimatableViewController {

  @IBOutlet var presentButton: AnimatableButton!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    // Set the transition animation type for `AnimatableViewController`, used for Present/Dismiss transitions
    if let toViewController = segue.destinationViewController as? AnimatableViewController {
      toViewController.transitionAnimationType = transitionAnimationType
      toViewController.interactiveGestureType = interactiveGestureType
    }
  }

  @IBAction func presentProgramatically() {
    if let presentedViewController = UIStoryboard(name: "Presentations", bundle: nil).instantiateViewControllerWithIdentifier("PresentationPresentedViewController") as? PresentationPresentedViewController {
      customPresent(presentedVC: presentedViewController)
    }
  }
}
