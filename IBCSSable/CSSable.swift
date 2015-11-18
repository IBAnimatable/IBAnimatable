//
//  CSSable.swift
//  IBCSSableApp
//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol CSSable {
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

  /**
   `color` when using with `box-shadow`
  */
  var shadowColor: UIColor { get set }

  /**
    Radius in `box-shadow`
  */
  var shadowRadius: CGFloat { get set }

  /**
   Opacity in `box-shadow`: from 0 to 1
  */
  var shadowOpacity: CGFloat { get set }

  /**
   Horizontal offset in `box-shadow`
  */
  var shadowOffsetX: CGFloat { get set }

  /**
   Vertical offset in `box-shadow`
  */
  var shadowOffsetY: CGFloat { get set }
}

public extension CSSable where Self:UIView {
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
    layer.masksToBounds = borderRadius > 0
  }
  
  public func configShadowColor() {
    layer.shadowColor = shadowColor.CGColor
  }

  public func configShadowRadius() {
    layer.shadowRadius = shadowRadius
  }

  public func configShadowOpacity() {
    layer.shadowOpacity = Float(shadowOpacity)
  }

  public func configShadowOffsetX() {
    layer.shadowOffset.width = shadowOffsetX
  }

  public func configShadowOffsetY() {
    layer.shadowOffset.height = shadowOffsetY
  }
}
