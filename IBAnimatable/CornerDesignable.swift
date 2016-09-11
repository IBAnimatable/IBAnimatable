//
//  Created by Jake Lin on 12/1/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol CornerDesignable {
  /**
   `border-radius`
   */
  var cornerRadius: CGFloat { get set }
}

public extension CornerDesignable where Self: UIView {
  public func configureCornerRadius() {
    if !cornerRadius.isNaN && cornerRadius > 0 {
      layer.cornerRadius = cornerRadius
    }
  }
}
