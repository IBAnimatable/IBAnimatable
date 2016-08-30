//
//  Created by Tom Baranes on 08/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentSlideWithDismissInteractionSegue: UIStoryboardSegue {
  open override func perform() {
    destination.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(transitionAnimationType: .slide(toDirection: .left, params: []), interactiveGestureType: .default)
    source.present(destination, animated: true, completion: nil)
  }
}
