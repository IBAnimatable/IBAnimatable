//
//  Created by Tom Baranes on 17/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentPortalSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.portal(direction: .forward, params: []))
    sourceViewController.present(destinationViewController, animated: true, completion: nil)
  }
}
