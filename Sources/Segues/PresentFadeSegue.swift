//
//  Created by Jake Lin on 2/28/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentFadeSegue: UIStoryboardSegue {
  open override func perform() {
    destination.transitioningDelegate = TransitionPresenterManager.shared.retrievePresenter(transitionAnimationType: .fade(direction: .cross))
    source.present(destination, animated: true, completion: nil)
  }
}
