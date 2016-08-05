//
//  Created by Tom Baranes on 28/06/16.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//


import UIKit

@IBDesignable public class AnimatableScrollView: UIScrollView, CornerDesignable, FillDesignable, BorderDesignable, RotationDesignable, ShadowDesignable, BlurDesignable, TintDesignable, GradientDesignable, MaskDesignable, Animatable {
  
  // MARK: - CornerDesignable
  @IBInspectable public var cornerRadius: CGFloat = CGFloat.nan {
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

  @IBInspectable public var opacity: CGFloat = CGFloat.nan {
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

  @IBInspectable public var borderWidth: CGFloat = CGFloat.nan {
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
  @IBInspectable public var rotate: CGFloat = CGFloat.nan {
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
  
  @IBInspectable public var shadowRadius: CGFloat = CGFloat.nan {
    didSet {
      configShadowRadius()
    }
  }
  
  @IBInspectable public var shadowOpacity: CGFloat = CGFloat.nan {
    didSet {
      configShadowOpacity()
    }
  }
  
  @IBInspectable public var shadowOffset: CGPoint = CGPoint(x: CGFloat.nan, y: CGFloat.nan) {
    didSet {
      configShadowOffset()
    }
  }
  // MARK: - BlurDesignable
  public var blurEffectStyle: UIBlurEffectStyle? {
    didSet {
      configBlurEffectStyle()
    }
  }
  @IBInspectable var _blurEffectStyle: String? {
    didSet {
      blurEffectStyle = UIBlurEffectStyle(string: _blurEffectStyle)
    }
  }

public var vibrancyEffectStyle: UIBlurEffectStyle? {
    didSet {
      configBlurEffectStyle()
    }
  }
  @IBInspectable var _vibrancyEffectStyle: String? {
    didSet {
      vibrancyEffectStyle = UIBlurEffectStyle(string: _vibrancyEffectStyle)
    }
  }

  @IBInspectable public var blurOpacity: CGFloat = CGFloat.nan {
    didSet {
      configBlurEffectStyle()
    }
  }

  // MARK: - TintDesignable
  @IBInspectable public var tintOpacity: CGFloat = CGFloat.nan
  @IBInspectable public var shadeOpacity: CGFloat = CGFloat.nan
  @IBInspectable public var toneColor: UIColor?
  @IBInspectable public var toneOpacity: CGFloat = CGFloat.nan

  // MARK: - GradientDesignable
  @IBInspectable public var startColor: UIColor?
  @IBInspectable public var endColor: UIColor?
  @IBInspectable public var predefinedGradient: String?
  @IBInspectable public var startPoint: String?
  
  // MARK: - MaskDesignable
  public var maskType: MaskType = .none {
    didSet {
      configMask()
      configBorder()
    }
  }
  
  /// The mask type used in Interface Builder. **Should not** use this property in code.
  @IBInspectable var _maskType: String? {
    didSet {
      maskType = MaskType(string: _maskType) ?? .none
    }
  }
  
  // MARK: - Animatable
public var animationType: AnimationType = .none
@IBInspectable  var _animationType: String? {
    didSet {
     animationType = AnimationType(string: _animationType)
    }
  }
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = Double.nan
  @IBInspectable public var delay: Double = Double.nan
  @IBInspectable public var damping: CGFloat = CGFloat.nan
  @IBInspectable public var velocity: CGFloat = CGFloat.nan
  @IBInspectable public var force: CGFloat = CGFloat.nan
  @IBInspectable public var repeatCount: Float = Float.nan
  
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
