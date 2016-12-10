//
//  Created by Tom Baranes on 09/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentFoldSegue: UIStoryboardSegue {
  open override func perform() {

    destination.transitioningDelegate = TransitionPresenterManager.shared.retrievePresenter(transitionAnimationType: .fold(from: .left, folds: nil))
    source.present(destination, animated: true, completion: nil)
  }
}
