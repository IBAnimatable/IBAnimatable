//
//  Created by Tom Baranes on 08/05/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentSlideSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.slide(toDirection: .left, params: []))
    sourceViewController.present(destinationViewController, animated: true, completion: nil)
  }
}
