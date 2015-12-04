//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol BorderDesignable {
  /**
    `border-color`
  */
  var borderColor: UIColor { get set }

  /**
    `border-width`
  */
  var borderWidth: CGFloat { get set }
}

public extension BorderDesignable where Self: UIView {
  public func configBorderColor() {
    layer.borderColor = borderColor.CGColor
  }
  
  public func configBorderWidth() {
    layer.borderWidth = borderWidth
  }
}
