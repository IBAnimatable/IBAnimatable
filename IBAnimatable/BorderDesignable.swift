//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol BorderDesignable {
  /**
    `border-color`, border color
  */
  var borderColor: UIColor? { get set }

  /**
   `border-width`, border width
   */
  var borderWidth: CGFloat { get set }
  
  /**
   border side: Top, Right, Bottom or Left, if not specified, all border sides will display,
   */
  var borderSide: String? { get set }
  
}

public extension BorderDesignable where Self: UIView {
  public func configBorder() {
    guard let unwrappedBorderColor = borderColor else {
      return
    }
    
    if borderWidth.isNaN || borderWidth <= 0 {
      return
    }
    
    // if borderSide has been specified, only display one side
    if let unwrappedBorderSide = borderSide, side = BorderSide(rawValue: unwrappedBorderSide) {
      let border = CALayer()
      border.name = "borderSideLayer"
      
      border.backgroundColor = unwrappedBorderColor.CGColor
      
      switch side {
      case .Top:
        border.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: borderWidth)
      case .Right:
        border.frame = CGRect(x: bounds.size.width - borderWidth, y: 0, width: borderWidth, height: bounds.size.height)
      case .Bottom:
        border.frame = CGRect(x: 0, y: bounds.size.height - borderWidth, width: bounds.size.width, height: borderWidth)
      case .Left:
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: bounds.size.height)
      }
      
      layer.addSublayer(border)
    } else {
      // Otherwise, display all border sides
      layer.borderColor = unwrappedBorderColor.CGColor
      layer.borderWidth = borderWidth
    }
  }
}
