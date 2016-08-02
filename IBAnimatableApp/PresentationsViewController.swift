//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class PresentationsViewController: AnimatableViewController {

  @IBOutlet var presentButton: AnimatableButton!
  var presentationAnimationType: String?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    if let toViewController = segue.destinationViewController as? AnimatableModalViewController {
      toViewController.presentationAnimationType = presentationAnimationType
      setDismissalAnimationTypeIfNeeded(toViewController)
    }
  }

  @IBAction func presentProgramatically() {
    if let presentedViewController = UIStoryboard(name: "Presentations", bundle: nil).instantiateViewControllerWithIdentifier("PresentationPresentedViewController") as? AnimatableModalViewController {
      presentedViewController.presentationAnimationType = presentationAnimationType
      setDismissalAnimationTypeIfNeeded(presentedViewController)
      presentViewController(presentedViewController, animated: true, completion: nil)
    }
  }
  
  private func setDismissalAnimationTypeIfNeeded(viewController: AnimatableModalViewController) {
    // FIXME: Dirty hack to make `Flip` and `CrossDissolve` work properly for dismissal transition.
    // If we don't apply this hack, both the dismissal transitions of `Flip` and `CrossDissolve` will slide down the modal not flip or crossDissolve(fade).
    if viewController.presentationAnimationType == "Flip" {
      viewController.dismissalAnimationType = "Flip"
    } else if viewController.presentationAnimationType == "CrossDissolve" {
      viewController.dismissalAnimationType = "CrossDissolve"
    }
  }
}
