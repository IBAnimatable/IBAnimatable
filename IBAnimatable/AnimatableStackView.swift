//
//  Created by Jake Lin on 12/11/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

// FIXME: almost same as `AnimatableView`, Need to refactor to encasuplate.
@IBDesignable public class AnimatableStackView: UIStackView, CornerDesignable, FillDesignable, BorderDesignable, RotationDesignable, ShadowDesignable, BlurDesignable, TintDesignable, GradientDesignable, Animatable {
  
  // MARK: - CornerDesignable
  @IBInspectable public var cornerRadius: CGFloat = 0 {
    didSet {
      configCornerRadius()
    }
  }
  
  // MARK: - FillDesignable
  @IBInspectable public var fillColor: UIColor = UIColor.whiteColor() {
    didSet {
      configFillColor()
    }
  }
  
  @IBInspectable public var opacity: CGFloat = 1 {
    didSet {
      configOpacity()
    }
  }
  
  // MARK: - BorderDesignable
  @IBInspectable public var borderColor: UIColor = UIColor.clearColor()
  @IBInspectable public var borderWidth: CGFloat = 0
  @IBInspectable public var borderSide: String = ""
  
  // MARK: - RotationDesignable
  @IBInspectable public var rotate: CGFloat = 0 {
    didSet {
      configRotate()
    }
  }
  
  // MARK: - ShadowDesignable
  @IBInspectable public var shadowColor: UIColor = UIColor.clearColor() {
    didSet {
      configShadowColor()
    }
  }
  
  @IBInspectable public var shadowRadius: CGFloat = 0 {
    didSet {
      configShadowRadius()
    }
  }
  
  @IBInspectable public var shadowOpacity: CGFloat = 0 {
    didSet {
      configShadowOpacity()
    }
  }
  
  @IBInspectable public var shadowOffsetX: CGFloat = 0 {
    didSet {
      configShadowOffsetX()
    }
  }
  
  @IBInspectable public var shadowOffsetY: CGFloat = 0 {
    didSet {
      configShadowOffsetY()
    }
  }
  
  // MARK: - BlurDesignable
  @IBInspectable public var blurEffectStyle: String = ""
  @IBInspectable public var blurOpacity: CGFloat = 1
  
  // MARK: - TintDesignable
  @IBInspectable public var tintOpacity: CGFloat = 0
  @IBInspectable public var shadeOpacity: CGFloat = 0
  @IBInspectable public var toneColor: UIColor = UIColor.clearColor()
  @IBInspectable public var toneOpacity: CGFloat = 0
  
  // MARK: - GradientDesignable
  @IBInspectable public var startColor: UIColor = UIColor.clearColor()
  @IBInspectable public var endColor: UIColor = UIColor.clearColor()
  @IBInspectable public var startPoint: String = "Top"
  
  // MARK: - Animatable
  @IBInspectable public var animationType: String = ""
  @IBInspectable public var duration: Double = 0.7
  @IBInspectable public var delay: Double = 0
  @IBInspectable public var force: CGFloat = 1
  @IBInspectable public var damping: CGFloat = 0.7
  @IBInspectable public var velocity: CGFloat = 0.7
  @IBInspectable public var repeatCount: Float = 1
  
  // MARK: - Lifecycle
  public override func prepareForInterfaceBuilder() {
    configDesignableProperties()
  }
  
  public override func awakeFromNib() {
    configDesignableProperties()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    startAnimation()
  }
  
  // MARK: - Private
  private func configDesignableProperties() {
    configBorder()
    configTintedColor()
    configBlurEffectStyle()
    configGradent()
  }
}
