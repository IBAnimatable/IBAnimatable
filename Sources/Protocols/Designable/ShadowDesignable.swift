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

// MARK: - UIView

extension ShadowDesignable where Self: UIView {
  public func configureShadowColor() {
    configureShadowColor(in: self)
  }

  public func configureShadowRadius() {
    configureShadowRadius(in: self)
  }

  public func configureShadowOpacity() {
    configureShadowOpacity(in: self)
  }

  public func configureShadowOffset() {
    configureShadowOffset(in: self)
  }

  public func configureMaskShadow() {
    configureMaskShadow(in: self)
  }
}

// MARK: - Common

extension ShadowDesignable {
  func configureShadowColor(in view: UIView) {
    if let shadowColor = shadowColor {
      commonSetup(in: view)
      view.layer.shadowColor = shadowColor.cgColor
    }
  }

  func configureShadowRadius(in view: UIView) {
    if !shadowRadius.isNaN && shadowRadius > 0 {
      commonSetup(in: view)
      view.layer.shadowRadius = shadowRadius
    }
  }

  func configureShadowOpacity(in view: UIView) {
    if !shadowOpacity.isNaN && shadowOpacity >= 0 && shadowOpacity <= 1 {
      commonSetup(in: view)
      view.layer.shadowOpacity = Float(shadowOpacity)
    }
  }

  func configureShadowOffset(in view: UIView) {
    if !shadowOffset.x.isNaN {
      commonSetup(in: view)
      view.layer.shadowOffset.width = shadowOffset.x
    }

    if !shadowOffset.y.isNaN {
      commonSetup(in: view)
      view.layer.shadowOffset.height = shadowOffset.y
    }
  }

  func configureMaskShadow(in view: UIView) {
    // if a `layer.mask` is specified, add a new shadow layer to display the shadow to match the mask shape.
    guard let mask = view.layer.mask as? CAShapeLayer else {
      return
    }

    commonSetup(in: view)

    // Clear default layer borders
    view.layer.shadowColor = nil
    view.layer.shadowRadius = 0
    view.layer.shadowOpacity = 0

    // Remove any previous shadow layer
    view.layer.superlayer?.sublayers?.filter { $0.name == "shadowLayer-\(Unmanaged.passUnretained(self))" }
      .forEach { $0.removeFromSuperlayer() }

    // Create new layer with object's memory reference to make this string unique. Otherwise common name will remove all the shadow layers as it's adding in layer's superview.
    let shadowLayer = CAShapeLayer()
    shadowLayer.name = "shadowLayer-\(Unmanaged.passUnretained(self))"
    shadowLayer.frame = view.frame

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
    view.layer.superlayer?.insertSublayer(shadowLayer, below: view.layer)
  }

  private func commonSetup(in view: UIView) {
    // Need to set `layer.masksToBounds` to `false`.
    // If `layer.masksToBounds == true` then shadow doesn't work any more.
    if view.layer.masksToBounds {
      view.layer.masksToBounds = false
    }
  }
}
