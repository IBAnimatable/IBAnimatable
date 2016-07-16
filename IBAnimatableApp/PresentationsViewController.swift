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

  @IBAction func presentProgramatically() {
    if let presentedViewController = UIStoryboard(name: "Presentations", bundle: nil).instantiateViewControllerWithIdentifier("PresentationPresentedViewController") as? PresentationPresentedViewController {
      presentViewController(presentedViewController, animated: true, completion: nil)
    }
  }
}
