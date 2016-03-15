//
//  Created by Jake Lin on 3/14/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentFadeWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.Fade, interactiveGestureType: .Default)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
