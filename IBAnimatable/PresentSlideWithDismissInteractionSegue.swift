//
//  Created by Tom Baranes on 08/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentSlideWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destination.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.slide(toDirection: .left, params: []), interactiveGestureType: .default)
    source.present(destination, animated: true, completion: nil)
  }
}
