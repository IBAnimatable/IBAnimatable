//
//  Created by Jake Lin on 12/14/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

// MARK: - UIStoryboardSegue
public extension UIViewController {
  @IBAction public func unwindToViewController(_ sender: UIStoryboardSegue) {
  }

  @IBAction public func dismissCurrentViewController(_ sender: UIStoryboardSegue) {
    sender.source.dismiss(animated: true, completion: nil)
  }

  @IBAction public func popToRootViewController(_ sender: UIStoryboardSegue) {
    if let navigationController = sender.source.navigationController {
      navigationController.popToRootViewController(animated: true)
    }
  }

}
