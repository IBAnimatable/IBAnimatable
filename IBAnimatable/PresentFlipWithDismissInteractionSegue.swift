//
//  Created by Tom Baranes on 05/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentFlipWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(.Flip(fromDirection: .Left), interactiveGestureType: .Default)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
