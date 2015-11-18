//
//  CSSBorderable.swift
//  IBCSSableApp
//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol CSSBorderable {
  /**
    `border-color`
  */
  var borderColor: UIColor { get set }

  /**
    `border-width`
  */
  var borderWidth: CGFloat { get set }

  /**
   `border-radius`
  */
  var borderRadius: CGFloat { get set }
}

public extension CSSBorderable where Self:UIView {
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
  
  public func configBorderRadius() {
    layer.cornerRadius = borderRadius
    // if `layer.masksToBounds == true` then shadow doesn't word any more.s
    // layer.masksToBounds = borderRadius > 0
  }
}
