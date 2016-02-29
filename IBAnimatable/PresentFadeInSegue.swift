//
//  Created by Jake Lin on 2/29/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentFadeInSegue: UIStoryboardSegue {
  @IBInspectable var duration: Double = 0.5
  
  public override func perform() {
    destinationViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.FadeIn)
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
