//
//  Created by Jake Lin on 3/14/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentFadeWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destination.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.fade(direction: .cross), interactiveGestureType: .default)
    source.present(destination, animated: true, completion: nil)
  }
}
