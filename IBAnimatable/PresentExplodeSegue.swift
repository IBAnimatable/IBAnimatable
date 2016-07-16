//
//  Created by Tom Baranes on 03/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentExplodeSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(.Explode(params: []))
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
