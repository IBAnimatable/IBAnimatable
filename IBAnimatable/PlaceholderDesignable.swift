//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol PlaceholderDesignable {
  /**
   `color` within `::-webkit-input-placeholder`, `::-moz-placeholder` or `:-ms-input-placeholder`
   */
  var placeholderColor: UIColor? { get set }
}

public extension PlaceholderDesignable where Self: UITextField {
  public func configPlaceholderColor() {
    if let unwrappedPlaceholderColor = placeholderColor {
      attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName: unwrappedPlaceholderColor])
    }
  }
}
