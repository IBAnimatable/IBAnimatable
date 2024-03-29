//
//  Created by Jake Lin on 12/25/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol RootWindowDesignable: AnyObject {
  /**
   Root window background color
   */
  var rootWindowBackgroundColor: UIColor? { get set }
}

public extension RootWindowDesignable where Self: UIViewController {

  func configureRootWindowBackgroundColor() {
    #if NS_EXTENSION_UNAVAILABLE_IOS

      if let rootWindowBackgroundColor = rootWindowBackgroundColor,
        let delegate = UIApplication.sharedApplication().delegate,
        let rootWindow = delegate.window {
          rootWindow?.backgroundColor = rootWindowBackgroundColor
      }

    #endif
  }

}
