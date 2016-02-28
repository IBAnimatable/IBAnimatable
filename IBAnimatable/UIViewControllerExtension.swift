//
//  Created by Jake Lin on 12/14/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

// MARK: - UIStoryboardSegue
public extension UIViewController {
  @IBAction public func unwindToViewController(sender: UIStoryboardSegue) {
  }
  
  @IBAction public func dismissCurrentViewController(sender: UIStoryboardSegue) {
    sender.sourceViewController.dismissViewControllerAnimated(true, completion: nil)
  }
}
