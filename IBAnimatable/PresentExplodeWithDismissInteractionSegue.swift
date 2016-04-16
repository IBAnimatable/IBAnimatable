//
//  Created by Tom Baranes on 03/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentExplodeWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.Explode(params: []), interactiveGestureType: .Default)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
