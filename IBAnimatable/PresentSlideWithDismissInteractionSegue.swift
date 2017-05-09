//
//  Created by Tom Baranes on 08/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentSlideWithDismissInteractionSegue: UIStoryboardSegue {
  open override func perform() {
    destination.transitioningDelegate = TransitionPresenterManager.shared.retrievePresenter(transitionAnimationType: .slide(to: .left, isFade: false),
                                                                                            interactiveGestureType: .default)
    source.present(destination, animated: true, completion: nil)
  }
}
