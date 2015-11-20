//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

/**
  These properties are not able to render in IB, it maybe a bug of IB.
 
  To use them, `UIView`'s `clipsToBounds` and `CALayer`'s `masksToBounds` (`Clip Subviews` in IB) must be `false`,
*/
public protocol BoxShadowDesignable {
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

public extension BoxShadowDesignable where Self:UIView {
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
