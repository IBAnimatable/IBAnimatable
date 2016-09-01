//
//  Created by Tom Baranes on 01/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentTurnSegue: UIStoryboardSegue {
  open override func perform() {
    destination.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(transitionAnimationType: .turn(fromDirection: .left))
    source.present(destination, animated: true, completion: nil)
  }
}
