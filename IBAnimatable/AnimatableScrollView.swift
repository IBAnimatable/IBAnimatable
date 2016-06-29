//
//  Created by Tom Baranes on 28/06/16.
//  Copyright © 2015 Jake Lin. All rights reserved.
//


import UIKit

@IBDesignable public class AnimatableScrollView: UIScrollView, CornerDesignable, FillDesignable, BorderDesignable, RotationDesignable, ShadowDesignable, BlurDesignable, TintDesignable, GradientDesignable, MaskDesignable, Animatable {
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

    // MARK: - CornerDesignable
    @IBInspectable public var cornerRadius: CGFloat = CGFloat.NaN {
=======
    
    // MARK: - CornerDesignable
    @IBInspectable public var cornerRadius: CGFloat = CGFloat.nan {
>>>>>>> Update Enums to camelCase
        didSet {
            configCornerRadius()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

=======
    
>>>>>>> Update Enums to camelCase
    // MARK: - FillDesignable
    @IBInspectable public var fillColor: UIColor? {
        didSet {
            configFillColor()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

=======
    
>>>>>>> Update Enums to camelCase
    @IBInspectable public var predefinedColor: String? {
        didSet {
            configFillColor()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

    @IBInspectable public var opacity: CGFloat = CGFloat.NaN {
=======
    
    @IBInspectable public var opacity: CGFloat = CGFloat.nan {
>>>>>>> Update Enums to camelCase
        didSet {
            configOpacity()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

=======
    
>>>>>>> Update Enums to camelCase
    // MARK: - BorderDesignable
    @IBInspectable public var borderColor: UIColor? {
        didSet {
            configBorder()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

    @IBInspectable public var borderWidth: CGFloat = CGFloat.NaN {
=======
    
    @IBInspectable public var borderWidth: CGFloat = CGFloat.nan {
>>>>>>> Update Enums to camelCase
        didSet {
            configBorder()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

=======
    
>>>>>>> Update Enums to camelCase
    @IBInspectable public var borderSide: String? {
        didSet {
            configBorder()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

    // MARK: - RotationDesignable
    @IBInspectable public var rotate: CGFloat = CGFloat.NaN {
=======
    
    // MARK: - RotationDesignable
    @IBInspectable public var rotate: CGFloat = CGFloat.nan {
>>>>>>> Update Enums to camelCase
        didSet {
            configRotate()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

=======
    
>>>>>>> Update Enums to camelCase
    // MARK: - ShadowDesignable
    @IBInspectable public var shadowColor: UIColor? {
        didSet {
            configShadowColor()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

    @IBInspectable public var shadowRadius: CGFloat = CGFloat.NaN {
=======
    
    @IBInspectable public var shadowRadius: CGFloat = CGFloat.nan {
>>>>>>> Update Enums to camelCase
        didSet {
            configShadowRadius()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

    @IBInspectable public var shadowOpacity: CGFloat = CGFloat.NaN {
=======
    
    @IBInspectable public var shadowOpacity: CGFloat = CGFloat.nan {
>>>>>>> Update Enums to camelCase
        didSet {
            configShadowOpacity()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

    @IBInspectable public var shadowOffset: CGPoint = CGPoint(x: CGFloat.NaN, y: CGFloat.NaN) {
=======
    
    @IBInspectable public var shadowOffset: CGPoint = CGPoint(x: CGFloat.nan, y: CGFloat.nan) {
>>>>>>> Update Enums to camelCase
        didSet {
            configShadowOffset()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

    // MARK: - BlurDesignable
    @IBInspectable public var blurEffectStyle: String?
    @IBInspectable public var blurOpacity: CGFloat = CGFloat.NaN

    // MARK: - TintDesignable
    @IBInspectable public var tintOpacity: CGFloat = CGFloat.NaN
    @IBInspectable public var shadeOpacity: CGFloat = CGFloat.NaN
    @IBInspectable public var toneColor: UIColor?
    @IBInspectable public var toneOpacity: CGFloat = CGFloat.NaN

=======
    
    // MARK: - BlurDesignable
    @IBInspectable public var blurEffectStyle: String?
    @IBInspectable public var blurOpacity: CGFloat = CGFloat.nan
    
    // MARK: - TintDesignable
    @IBInspectable public var tintOpacity: CGFloat = CGFloat.nan
    @IBInspectable public var shadeOpacity: CGFloat = CGFloat.nan
    @IBInspectable public var toneColor: UIColor?
    @IBInspectable public var toneOpacity: CGFloat = CGFloat.nan
    
>>>>>>> Update Enums to camelCase
    // MARK: - GradientDesignable
    @IBInspectable public var startColor: UIColor?
    @IBInspectable public var endColor: UIColor?
    @IBInspectable public var predefinedGradient: String?
    @IBInspectable public var startPoint: String?
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

=======
    
>>>>>>> Update Enums to camelCase
    // MARK: - MaskDesignable
    @IBInspectable public var maskType: String? {
        didSet {
            configMask()
            configBorder()
        }
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

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

=======
    
    // MARK: - Animatable
    @IBInspectable public var animationType: String?
    @IBInspectable public var autoRun: Bool = true
    @IBInspectable public var duration: Double = Double.nan
    @IBInspectable public var delay: Double = Double.nan
    @IBInspectable public var damping: CGFloat = CGFloat.nan
    @IBInspectable public var velocity: CGFloat = CGFloat.nan
    @IBInspectable public var force: CGFloat = CGFloat.nan
    @IBInspectable public var repeatCount: Float = Float.nan
//    @IBInspectable public var x: CGFloat = CGFloat.nan
//    @IBInspectable public var y: CGFloat = CGFloat.nan
    
>>>>>>> Update Enums to camelCase
    // MARK: - Lifecycle
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configInspectableProperties()
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

=======
    
>>>>>>> Update Enums to camelCase
    public override func awakeFromNib() {
        super.awakeFromNib()
        configInspectableProperties()
    }
<<<<<<< 9e52fe89fbf186dcb53a761826c0804187075a28

=======
    
>>>>>>> Update Enums to camelCase
    public override func layoutSubviews() {
        super.layoutSubviews()
        configAfterLayoutSubviews()
        autoRunAnimation()
    }
    
    // MARK: - Private
    private func configInspectableProperties() {
        configAnimatableProperties()
        configTintedColor()
        configBlurEffectStyle()
    }
    
    private func configAfterLayoutSubviews() {
        configMask()
        configBorder()
        configGradient()
    }
}
