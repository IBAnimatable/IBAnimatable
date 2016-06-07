//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol PaddingDesignable {
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
  public func configPaddingLeft() {
    if paddingLeft.isNaN {
      return
    }
    
    let padding = UIView(frame: CGRect(x: 0, y: 0, width: paddingLeft, height: 0))
    leftViewMode = .Always
    leftView = padding
  }
  
  public func configPaddingRight() {
    if paddingRight.isNaN {
      return
    }
    
    let padding = UIView(frame: CGRect(x: 0, y: 0, width: paddingRight, height: 0))
    rightViewMode = .Always
    rightView = padding
  }

  public func configPaddingSide() {
    if paddingSide.isNaN {
      return
    }
    
    let padding = UIView(frame: CGRect(x: 0, y: 0, width: paddingSide, height: paddingSide))
    leftViewMode = .Always
    leftView = padding

    rightViewMode = .Always
    rightView = padding
  }
}
