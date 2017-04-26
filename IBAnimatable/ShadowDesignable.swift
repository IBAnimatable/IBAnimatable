//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

/**
  These properties are not able to render in IB correctly, it maybe a bug of IB.

  To use them, `UIView`'s `clipsToBounds` and `CALayer`'s `masksToBounds` (`Clip Subviews` in IB) must be `false`,
*/
public protocol ShadowDesignable: class {
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
   Offset in `box-shadow`. `x` is horizontal offset and `y` is vertical offset
  */
  var shadowOffset: CGPoint { get set }
}

public extension ShadowDesignable where Self: UIView {
  public func configureShadowColor() {
    if let shadowColor = shadowColor {
      commonSetup()
      layer.shadowColor = shadowColor.cgColor
    }
  }

  public func configureShadowRadius() {
    if !shadowRadius.isNaN && shadowRadius > 0 {
      commonSetup()
      layer.shadowRadius = shadowRadius
    }
  }

  public func configureShadowOpacity() {
    if !shadowOpacity.isNaN && shadowOpacity >= 0 && shadowOpacity <= 1 {
      commonSetup()
      layer.shadowOpacity = Float(shadowOpacity)
    }
  }

  public func configureShadowOffset() {
    if !shadowOffset.x.isNaN {
      commonSetup()
      layer.shadowOffset.width = shadowOffset.x
    }

    if !shadowOffset.y.isNaN {
      commonSetup()
      layer.shadowOffset.height = shadowOffset.y
    }
  }

  public func configureMaskShadow() {
    // if a `layer.mask` is specified, add a new shadow layer to display the shadow to match the mask shape.
    if let mask = layer.mask as? CAShapeLayer {
      commonSetup()

      // Clear default layer borders
      layer.shadowColor = nil
      layer.shadowRadius = 0
      layer.shadowOpacity = 0

      // Remove any previous shadow layer
      layer.superlayer?.sublayers?.filter { $0.name == "shadowLayer-\(Unmanaged.passUnretained(self))" }
        .forEach { $0.removeFromSuperlayer() }

      // Create new layer with object's memory reference to make this string unique. Otherwise common name will remove all the shadow layers as it's adding in layer's superview.
      let shadowLayer = CAShapeLayer()
      shadowLayer.name = "shadowLayer-\(Unmanaged.passUnretained(self))"
      shadowLayer.frame = frame

      // Configure shadow properties
      if let shadowColor = shadowColor {
        shadowLayer.shadowColor = shadowColor.cgColor
      }
      if !shadowRadius.isNaN && shadowRadius > 0 {
        shadowLayer.shadowRadius = shadowRadius
      }
      if !shadowOpacity.isNaN && shadowOpacity >= 0 && shadowOpacity <= 1 {
        shadowLayer.shadowOpacity = Float(shadowOpacity)
      }
      if !shadowOffset.x.isNaN {
        shadowLayer.shadowOffset.width = shadowOffset.x
      }
      if !shadowOffset.y.isNaN {
        shadowLayer.shadowOffset.height = shadowOffset.y
      }
      shadowLayer.shadowPath = mask.path

      // Add to layer's superview in order to render shadow otherwise it will clip out due to mask layer.
      layer.superlayer?.insertSublayer(shadowLayer, below: layer)
    }
  }

  fileprivate func commonSetup() {
    // Need to set `layer.masksToBounds` to `false`.
    // If `layer.masksToBounds == true` then shadow doesn't work any more.
    if layer.masksToBounds {
      layer.masksToBounds = false
    }
  }
}
