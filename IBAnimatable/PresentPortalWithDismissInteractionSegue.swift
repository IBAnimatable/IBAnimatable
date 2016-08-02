//
//  Created by Tom Baranes on 17/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentPortalWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(.Portal(direction: .Forward, params: []), interactiveGestureType: .Default)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
