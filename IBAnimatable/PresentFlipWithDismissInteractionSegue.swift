//
//  Created by Tom Baranes on 05/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentFlipWithDismissInteractionSegue: UIStoryboardSegue {
  public override func perform() {
    destination.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.flip(fromDirection: .left), interactiveGestureType: .default)
    source.present(destination, animated: true, completion: nil)
  }
}
