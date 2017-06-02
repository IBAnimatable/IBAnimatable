//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol PaddingDesignable: class {
  
  var leftTextPadding: CGFloat { get set }
  
  var rightTextPadding: CGFloat { get set }
  
  var sideTextPadding: CGFloat { get set }
  
  var leftEditPadding: CGFloat { get set }
  
  var rightEditPadding: CGFloat { get set }
  
  var sideEditPadding: CGFloat { get set }
  
  var leftPlaceholderPadding: CGFloat { get set }
  
  var rightPlaceholderPadding: CGFloat { get set }
  
  var sidePlaceholderPadding: CGFloat { get set }
  
}

public extension PaddingDesignable where Self: UITextField {
  
  public var textRectInsets: UIEdgeInsets {
    if sideTextPadding.isNaN {
      return insets(left: leftTextPadding, right: rightTextPadding)
    } else {
      return sideInsets(padding: sideTextPadding)
    }
  }
  
  public var editRectInsets: UIEdgeInsets {
    if sideEditPadding.isNaN {
      return insets(left: leftEditPadding, right: rightEditPadding)
    } else {
      return sideInsets(padding: sideEditPadding)
    }
  }
  
  public var placeholderRectInsets: UIEdgeInsets {
    if sidePlaceholderPadding.isNaN {
      return insets(left: leftPlaceholderPadding, right: rightPlaceholderPadding)
    } else {
      return sideInsets(padding: sidePlaceholderPadding)
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
