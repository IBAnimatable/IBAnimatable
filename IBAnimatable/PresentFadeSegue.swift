//
//  Created by Jake Lin on 2/28/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

var fade: Presenter?
public class PresentFadeSegue: UIStoryboardSegue {
  public override func perform() {
    fade = Presenter(transitionAnimationType: .Fade, transitionDuration: defaultTransitionDuration)
    destinationViewController.transitioningDelegate = fade
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }
}
