//
//  Created by Tom Baranes on 08/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentSlideSegue: UIStoryboardSegue {
  public override func perform() {
    destinationViewController.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(.Slide(toDirection: .Left, params: []))
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
