//
//  Created by Tom Baranes on 17/04/16.
//  Updated by Mark Hamilton on 5/30/16
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentPortalWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.Portal(direction: .Forward, params: []), interactiveGestureType: .Default)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
  public func perform(completion: OptionalAnimatableCompletion) {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.Portal(direction: .Forward, params: []), interactiveGestureType: .Default)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: completion)
  }
}
