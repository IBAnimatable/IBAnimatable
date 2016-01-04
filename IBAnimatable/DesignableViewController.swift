//
//  Created by Jake Lin on 12/14/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class DesignableViewController: UIViewController, ViewControllerDesignable, StatusBarDesignable, RootWindowDesignable {
  // MARK: - ViewControllerDesignable
  @IBInspectable public var hideNavigationBar: Bool = false
  
  // MARK: - StatusBarDesignable
  @IBInspectable public var lightStatusBar: Bool = false
  
  // MARK: - RootWindowDesignable
  @IBInspectable public var rootWindowBackgroundColor: UIColor?
  
  // MARK: - Lifecylce
  public override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    confingHideNavigationBar()
    configRootWindowBackgroundColor()
  }
  
  public override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    resetHideNavigationBar()
  }
  
  public override func preferredStatusBarStyle() -> UIStatusBarStyle {
    if lightStatusBar {
      return .LightContent
    }
    return .Default
  }
}
