//
//  Created by Tom Baranes on 01/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentCardsSegue: UIStoryboardSegue {
  open override func perform() {
    destination.transitioningDelegate = TransitionPresenterManager.shared.retrievePresenter(transitionAnimationType: .cards(direction: .forward))
    source.present(destination, animated: true, completion: nil)
  }
}
