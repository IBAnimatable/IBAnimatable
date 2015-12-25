//
//  Created by Jake Lin on 12/25/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol RootWindowDesignable {
  /**
   Root window background color
   */
  var rootWindowBackgroundColor: UIColor { get set }
}

public extension RootWindowDesignable where Self: UIViewController {
  public func configRootWindowBackgroundColor() {
    if rootWindowBackgroundColor == UIColor.clearColor() {
      return
    }
    
    if let delegate = UIApplication.sharedApplication().delegate {
      if let rootWindow = delegate.window {
        rootWindow?.backgroundColor = rootWindowBackgroundColor
      }
    }
  }
}
