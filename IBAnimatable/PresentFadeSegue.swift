//
//  Created by Jake Lin on 2/28/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentFadeSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(.Fade(direction: .Cross))
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
