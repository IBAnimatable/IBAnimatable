//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableImageView: UIImageView, CornerDesignable, FillDesignable, BorderDesignable, RotationDesignable, ShadowDesignable, BlurDesignable, TintDesignable, GradientDesignable, MaskDesignable, Animatable {
  
  // MARK: - CornerDesignable
  @IBInspectable public var cornerRadius: CGFloat = CGFloat.NaN {
    didSet {
      configCornerRadius()
    }
  }

  // MARK: - FillDesignable
  @IBInspectable public var fillColor: UIColor? {
    didSet {
      configFillColor()
    }
  }

  @IBInspectable public var opacity: CGFloat = CGFloat.NaN {
    didSet {
      configOpacity()
    }
  }
  
  // MARK: - BorderDesignable
  @IBInspectable public var borderColor: UIColor?
  @IBInspectable public var borderWidth: CGFloat = CGFloat.NaN
  @IBInspectable public var borderSide: String?
  
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
  @IBInspectable public var blurEffectStyle: String?
  @IBInspectable public var blurOpacity: CGFloat = CGFloat.NaN
  
  // MARK: - TintDesignable
  @IBInspectable public var tintOpacity: CGFloat = 0
  @IBInspectable public var shadeOpacity: CGFloat = 0
  @IBInspectable public var toneColor: UIColor = UIColor.clearColor()
  @IBInspectable public var toneOpacity: CGFloat = 0
  
  // MARK: - GradientDesignable
  @IBInspectable public var startColor: UIColor?
  @IBInspectable public var endColor: UIColor?
  @IBInspectable public var startPoint: String?
  
  // MARK: - MaksDesignable
  @IBInspectable public var maskType: String? {
    didSet {
      configMask()
    }
  }
  
  // MARK: - Animatable
  @IBInspectable public var animationType: String = ""
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = 0.7
  @IBInspectable public var delay: Double = 0
  @IBInspectable public var damping: CGFloat = 0.7
  @IBInspectable public var velocity: CGFloat = 0.7
  @IBInspectable public var force: CGFloat = 1
  @IBInspectable public var repeatCount: Float = 1
  
  // MARK: - Lifecycle
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configDesignableProperties()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    configDesignableProperties()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    autoRunAnimation()
  }
  
  // MARK: - Private
  private func configDesignableProperties() {
    configBorder()
    configTintedColor()
    configBlurEffectStyle()
    configGradent()
  }
}
