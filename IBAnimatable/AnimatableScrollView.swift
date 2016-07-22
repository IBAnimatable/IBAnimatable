//
//  Created by Tom Baranes on 28/06/16.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//


import UIKit

@IBDesignable public class AnimatableScrollView: UIScrollView, CornerDesignable, FillDesignable, BorderDesignable, RotationDesignable, ShadowDesignable, BlurDesignable, TintDesignable, GradientDesignable, MaskDesignable, Animatable {

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

  @IBInspectable public var predefinedColor: String? {
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
  @IBInspectable public var borderColor: UIColor? {
    didSet {
      configBorder()
    }
  }

  @IBInspectable public var borderWidth: CGFloat = CGFloat.NaN {
    didSet {
      configBorder()
    }
  }

  @IBInspectable public var borderSide: String? {
    didSet {
      configBorder()
    }
  }

  // MARK: - RotationDesignable
  @IBInspectable public var rotate: CGFloat = CGFloat.NaN {
    didSet {
      configRotate()
    }
  }

  // MARK: - ShadowDesignable
  @IBInspectable public var shadowColor: UIColor? {
    didSet {
      configShadowColor()
    }
  }

  @IBInspectable public var shadowRadius: CGFloat = CGFloat.NaN {
    didSet {
      configShadowRadius()
    }
  }

  @IBInspectable public var shadowOpacity: CGFloat = CGFloat.NaN {
    didSet {
      configShadowOpacity()
    }
  }

  @IBInspectable public var shadowOffset: CGPoint = CGPoint(x: CGFloat.NaN, y: CGFloat.NaN) {
    didSet {
      configShadowOffset()
    }
  }

  // MARK: - BlurDesignable
  @IBInspectable public var blurEffectStyle: String? {
    didSet {
      configBlurEffectStyle()
    }
  }

  @IBInspectable public var vibrancyEffectStyle: String? {
    didSet {
      configBlurEffectStyle()
    }
  }

  @IBInspectable public var blurOpacity: CGFloat = CGFloat.NaN {
    didSet {
      configBlurEffectStyle()
    }
  }

  // MARK: - TintDesignable
  @IBInspectable public var tintOpacity: CGFloat = CGFloat.NaN
  @IBInspectable public var shadeOpacity: CGFloat = CGFloat.NaN
  @IBInspectable public var toneColor: UIColor?
  @IBInspectable public var toneOpacity: CGFloat = CGFloat.NaN

  // MARK: - GradientDesignable
  @IBInspectable public var startColor: UIColor?
  @IBInspectable public var endColor: UIColor?
  @IBInspectable public var predefinedGradient: String?
  @IBInspectable public var startPoint: String?

  // MARK: - MaskDesignable
  @IBInspectable public var maskType: String? {
    didSet {
      configMask()
      configBorder()
    }
  }

  // MARK: - Animatable
  @IBInspectable public var animationType: String?
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = Double.NaN
  @IBInspectable public var delay: Double = Double.NaN
  @IBInspectable public var damping: CGFloat = CGFloat.NaN
  @IBInspectable public var velocity: CGFloat = CGFloat.NaN
  @IBInspectable public var force: CGFloat = CGFloat.NaN
  @IBInspectable public var repeatCount: Float = Float.NaN
  @IBInspectable public var x: CGFloat = CGFloat.NaN
  @IBInspectable public var y: CGFloat = CGFloat.NaN

  // MARK: - Lifecycle
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configInspectableProperties()
  }

  public override func awakeFromNib() {
    super.awakeFromNib()
    configInspectableProperties()
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    configAfterLayoutSubviews()
    autoRunAnimation()
  }

  // MARK: - Private
  private func configInspectableProperties() {
    configAnimatableProperties()
    configTintedColor()  
  }

  private func configAfterLayoutSubviews() {
    configMask()
    configBorder()
    configGradient()
  }
}
