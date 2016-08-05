//
//  Created by Tom Baranes on 01/05/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PresentTurnSegue: UIStoryboardSegue {
  public override func perform() {
    destination.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(.turn(fromDirection: .left))
    source.present(destination, animated: true, completion: nil)
  }
}
