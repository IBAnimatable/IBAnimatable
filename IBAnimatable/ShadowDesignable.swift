//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

/**
  These properties are not able to render in IB correctly, it maybe a bug of IB.
 
  To use them, `UIView`'s `clipsToBounds` and `CALayer`'s `masksToBounds` (`Clip Subviews` in IB) must be `false`,
*/
public protocol ShadowDesignable {
  /**
   `color` when using with `box-shadow`
  */
  var shadowColor: UIColor? { get set }

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

public extension ShadowDesignable where Self: UIView {
  
  // if `layer.masksToBounds == true` then shadow doesn't work any more.
  public func configShadowColor() {
    if let unwrappedShadowColor = shadowColor {
      layer.shadowColor = unwrappedShadowColor.CGColor
      layer.masksToBounds = false
    }
  }

  public func configShadowRadius() {
    if !shadowRadius.isNaN {
      layer.shadowRadius = shadowRadius
      layer.masksToBounds = false
    }
  }

  public func configShadowOpacity() {
    if !shadowOpacity.isNaN {
      layer.shadowOpacity = Float(shadowOpacity)
      layer.masksToBounds = false
    }
  }

  public func configShadowOffsetX() {
    layer.shadowOffset.width = shadowOffsetX
    layer.masksToBounds = false
  }

  public func configShadowOffsetY() {
    layer.shadowOffset.height = shadowOffsetY
    layer.masksToBounds = false
  }
}
