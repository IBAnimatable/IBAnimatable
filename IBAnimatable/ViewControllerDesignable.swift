//
//  Created by Jake Lin on 12/14/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol ViewControllerDesignable: class {
  var hideNavigationBar: Bool { get set }
}

public extension ViewControllerDesignable where Self: UIViewController {
  public func configureHideNavigationBar() {
    navigationController?.isNavigationBarHidden = hideNavigationBar
  }

  public func resetHideNavigationBar() {
    navigationController?.isNavigationBarHidden = false
  }
}
