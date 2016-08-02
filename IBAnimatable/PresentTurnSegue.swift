//
//  Created by Tom Baranes on 01/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentTurnSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(.Turn(fromDirection: .Left))
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
