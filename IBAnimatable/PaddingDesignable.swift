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
    
    let padding = UIView(frame: CGRectMake(0, 0, paddingLeft, 0))
    leftViewMode = .Always
    leftView = padding
  }
  
  public func configPaddingRight() {
    if paddingRight.isNaN {
      return
    }
    
    let padding = UIView(frame: CGRectMake(0, 0, paddingRight, 0))
    rightViewMode = .Always
    rightView = padding
  }

  public func configPaddingSide() {
    if paddingSide.isNaN {
      return
    }
    
    let padding = UIView(frame: CGRectMake(0, 0, paddingSide, paddingSide))
    leftViewMode = .Always
    leftView = padding

    rightViewMode = .Always
    rightView = padding
  }
}
