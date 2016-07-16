//
//  Created by Tom Baranes on 09/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentFoldSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(.Fold(fromDirection: .Left, params: []))
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
