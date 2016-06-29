//
//  Created by Jake Lin on 3/14/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentFadeWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.fade(direction: .cross), interactiveGestureType: .default)
    sourceViewController.present(destinationViewController, animated: true, completion: nil)
  }
}
