//
//  Created by Jake Lin on 3/15/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentFadeOutWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.FadeOut, interactiveGestureType: .Default)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
