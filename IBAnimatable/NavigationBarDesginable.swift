//
//  Created by Jake Lin on 12/10/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol NavigationBarDesignable: class {
  /**
   Specify whether is solid color only, if `true` will remove hairline from navigation bar
   */
  var solidColor: Bool { get set }
}

public extension NavigationBarDesignable where Self: UINavigationBar {
  public func configureNavigationBar() {
    if solidColor {
      let emptyImage = UIImage()
      setBackgroundImage(emptyImage, for: .any, barMetrics: .default)
      shadowImage = emptyImage
      // Need to manually untick translucent in Interface Builder,
      // otherwise, it will have constrait issue in IB although it is correct in run time.
      // translucent = false
    } else {
      setBackgroundImage(nil, for: .any, barMetrics: .default)
      shadowImage = nil
    }
  }
}
