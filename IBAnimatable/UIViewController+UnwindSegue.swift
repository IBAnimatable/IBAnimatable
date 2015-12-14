//
//  Created by Jake Lin on 12/14/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public extension UIViewController {
  @IBAction public func unwindToViewController (sender: UIStoryboardSegue) {
    print(sender.sourceViewController)
  }
}
