//
//  Created by Jake Lin on 12/25/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol RootWindowDesignable {
  /**
   Root window background color
   */
  var rootWindowBackgroundColor: UIColor? { get set }
}

public extension RootWindowDesignable where Self: UIViewController {
  public func configRootWindowBackgroundColor() {
    if let wrappedRootWindowBackgroundColor = rootWindowBackgroundColor,
      delegate = UIApplication.sharedApplication().delegate, rootWindow = delegate.window {
      rootWindow?.backgroundColor = wrappedRootWindowBackgroundColor
    }
  }
}
