//
//  Created by Tom Baranes on 17/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentPortalWithDismissInteractionSegue: UIStoryboardSegue {
  open override func perform() {
    destination.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(transitionAnimationType: .portal(direction: .forward, params: []), interactiveGestureType: .default)
    source.present(destination, animated: true, completion: nil)
  }
}
