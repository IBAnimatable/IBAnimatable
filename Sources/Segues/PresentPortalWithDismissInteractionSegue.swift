//
//  Created by Tom Baranes on 17/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentPortalWithDismissInteractionSegue: UIStoryboardSegue {
  open override func perform() {
    let transitionAnimationType: TransitionAnimationType = .portal(direction: .forward, zoomScale: nil)
    destination.transitioningDelegate = TransitionPresenterManager.shared.retrievePresenter(transitionAnimationType: transitionAnimationType,
                                                                                            interactiveGestureType: .default)
    source.present(destination, animated: true, completion: nil)
  }
}
