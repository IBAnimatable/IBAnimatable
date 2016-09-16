//
//  Created by Tom Baranes on 17/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentPortalSegue: UIStoryboardSegue {
  open override func perform() {
    destination.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(transitionAnimationType: .portal(direction: .forward, zoomScale: nil))
    source.present(destination, animated: true, completion: nil)
  }
}
