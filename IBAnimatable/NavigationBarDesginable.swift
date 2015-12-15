//
//  Created by Jake Lin on 12/10/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol NavigationBarDesignable {
  /**
   Specify whether is solid color only, if `true` will remove hairline from navigation bar
   */
  var solidColor: Bool { get set }
}

public extension NavigationBarDesignable where Self: UINavigationBar {
  public func configNavigationBar() {
    if (solidColor) {
      let emptyImage = UIImage()
      setBackgroundImage(emptyImage, forBarPosition: .Any, barMetrics: .Default)
      shadowImage = emptyImage
      // Need to manually untick translucent in Interface Builder, 
      // otherwise, it will have constrait issue in IB although it is correct in run time.
      // translucent = false
    }
    else {
      setBackgroundImage(nil, forBarPosition: .Any, barMetrics: .Default)
      shadowImage = nil
    }
  }
}
