//
//  Created by Tom Baranes on 05/05/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentFlipWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.flip(fromDirection: .left), interactiveGestureType: .default)
    sourceViewController.present(destinationViewController, animated: true, completion: nil)
  }
}
