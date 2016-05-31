//
//  Created by Jake Lin on 12/14/15.
//  Updated by Mark Hamilton on 5/30/16
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public class DismissSegue: UIStoryboardSegue {
  public override func perform() {
    sourceViewController.dismissViewControllerAnimated(true, completion: nil)
  }
  public func perform(completion: OptionalAnimatableCompletion) {
    sourceViewController.dismissViewControllerAnimated(true, completion: completion)
  }
}
