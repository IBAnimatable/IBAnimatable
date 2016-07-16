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
    if let toViewController = segue.destinationViewController as? AnimatablePresentedViewController {
      toViewController.presentationAnimationType = presentationAnimationType
    }
  }

  @IBAction func presentProgramatically() {
    if let presentedViewController = UIStoryboard(name: "Presentations", bundle: nil).instantiateViewControllerWithIdentifier("PresentationPresentedViewController") as? PresentationPresentedViewController {
      presentedViewController.presentationAnimationType = presentationAnimationType
      presentViewController(presentedViewController, animated: true, completion: nil)
    }
  }
}
