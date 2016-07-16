//
//  Created by Jake Lin on 3/14/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentFadeWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(.Fade(direction: .Cross), interactiveGestureType: .Default)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
