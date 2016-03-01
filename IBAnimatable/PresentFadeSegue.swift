//
//  Created by Jake Lin on 2/28/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentFadeSegue: UIStoryboardSegue {
  public override func perform() {
      destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.Fade)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
