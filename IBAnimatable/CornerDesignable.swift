//
//  Created by Jake Lin on 12/1/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol CornerDesignable {
  /**
   `border-radius`
   */
  var cornerRadius: CGFloat { get set }
}

public extension CornerDesignable where Self: UIView {
  public func configCornerRadius() {
    if !cornerRadius.isNaN && cornerRadius > 0 {
      layer.cornerRadius = cornerRadius
    }
  }
}
