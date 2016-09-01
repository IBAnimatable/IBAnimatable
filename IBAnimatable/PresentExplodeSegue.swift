//
//  Created by Tom Baranes on 03/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentExplodeSegue: UIStoryboardSegue {
  open override func perform() {
    destination.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(transitionAnimationType: .explode(params: []))
    source.present(destination, animated: true, completion: nil)
  }
}
