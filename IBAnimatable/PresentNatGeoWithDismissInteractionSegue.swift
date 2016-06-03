//
//  Created by Tom Baranes on 24/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentNatGeoWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.NatGeo(toDirection: .Left), interactiveGestureType: .Default)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
  public func perform(completion: OptionalAnimatableCompletion) {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.NatGeo(toDirection: .Left), interactiveGestureType: .Default)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: completion)
  }
}
