//
//  Created by Jake Lin on 12/14/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol ViewControllerDesignable: class {
  var hideNavigationBar: Bool { get set }
}

public extension ViewControllerDesignable where Self: UIViewController {
  func configureHideNavigationBar() {
    navigationController?.isNavigationBarHidden = hideNavigationBar
  }

  func resetHideNavigationBar() {
    navigationController?.isNavigationBarHidden = false
  }
}
