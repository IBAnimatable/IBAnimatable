//
//  Created by Tom Baranes on 01/05/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentTurnSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.turn(fromDirection: .left))
    sourceViewController.present(destinationViewController, animated: true, completion: nil)
  }
}
