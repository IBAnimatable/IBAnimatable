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

public extension BorderDesignable where Self : UIView {
//  // Only instance properties can be declared @IBInspectable
//  // @IBInspectable 
//  public var borderRadius: CGFloat {
//    get {
//      return layer.cornerRadius
//    }
//    set {
//      layer.cornerRadius = borderRadius
//      layer.masksToBounds = borderRadius > 0
//    }
//  }
  
  public func configBorderColor() {
    layer.borderColor = borderColor.CGColor
  }
  
  public func configBorderWidth() {
    layer.borderWidth = borderWidth
  }
}
