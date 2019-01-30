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

  func paddedRect(forBounds bounds: CGRect) -> CGRect {
    if paddingSide.isNaN && paddingLeft.isNaN && paddingRight.isNaN {
      return bounds
    }
    return bounds.inset(by: paddingInsets)
  }

  private var paddingInsets: UIEdgeInsets {
    if paddingSide.isNaN {
      return insets(left: paddingLeft, right: paddingRight)
    } else {
      return sideInsets(padding: paddingSide)
    }
  }

  private func sideInsets(padding: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
  }

  private func insets(left: CGFloat, right: CGFloat) -> UIEdgeInsets {
    let l = left.isNaN ? 0 : left
    let r = right.isNaN ? 0 : right
    return UIEdgeInsets(top: 0, left: l, bottom: 0, right: r)
  }

}
