//
//  Created by Tom Baranes on 17/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentPortalWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destination.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.portal(direction: .forward, params: []), interactiveGestureType: .default)
    source.present(destination, animated: true, completion: nil)
  }
}
