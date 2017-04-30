//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol PaddingDesignable: class {
  /**
    `padding-left`
  */
  var paddingLeft: CGFloat { get set }

  /**
    `padding-right`
  */
  var paddingRight: CGFloat { get set }

  /**
   `padding-left` and `padding-right`
  */
  var paddingSide: CGFloat { get set }
}

public extension PaddingDesignable where Self: UITextField {
  public func configurePaddingLeft() {
    if paddingLeft.isNaN {
      return
    }

    let padding = UIView(frame: CGRect(x: 0, y: 0, width: paddingLeft, height: 0))
    leftViewMode = .always
    leftView = padding
  }

  public func configurePaddingRight() {
    if paddingRight.isNaN {
      return
    }

    let padding = UIView(frame: CGRect(x: 0, y: 0, width: paddingRight, height: 0))
    rightViewMode = .always
    rightView = padding
  }

  public func configurePaddingSide() {
    if paddingSide.isNaN {
      return
    }

    let padding = UIView(frame: CGRect(x: 0, y: 0, width: paddingSide, height: paddingSide))
    leftViewMode = .always
    leftView = padding

    rightViewMode = .always
    rightView = padding
  }
}
