//
//  Created by Jake Lin on 12/14/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public class DismissSegue: UIStoryboardSegue {
  public override func perform() {
    sourceViewController.dismissViewControllerAnimated(true, completion: nil)
  }
}
