//
//  Created by Jake Lin on 12/14/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol ViewControllerDesignable {
  var hideNavigationBar: Bool { get set }
}

public extension ViewControllerDesignable where Self: UIViewController {
  public func confingHideNavigationBar() {
    navigationController?.navigationBarHidden = hideNavigationBar
  }
  
  public func resetHideNavigationBar() {
    navigationController?.navigationBarHidden = false
  }
}
