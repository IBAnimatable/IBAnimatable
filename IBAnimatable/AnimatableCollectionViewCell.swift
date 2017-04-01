//
//  Created by Tom Baranes on 11/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable
open class AnimatableCollectionViewCell: UICollectionViewCell, CornerDesignable, FillDesignable, BorderDesignable,
                                                               ShadowDesignable, TableViewCellDesignable, GradientDesignable,
                                                               BackgroundImageDesignable, Animatable {

  // MARK: - CornerDesignable
  @IBInspectable open var cornerRadius: CGFloat = CGFloat.nan {
    didSet {
      configureCornerRadius()
    }
  }

  open var cornerSides: CornerSides  = .allSides {
    didSet {
      configureCornerRadius()
    }
  }

  @IBInspectable var _cornerSides: String? {
    didSet {
      cornerSides = CornerSides(rawValue: _cornerSides)
    }
  }

  // MARK: - ShadowDesignable
  @IBInspectable open var shadowColor: UIColor? {
    didSet {
      configureShadowColor()
    }
  }

  @IBInspectable open var shadowRadius: CGFloat = CGFloat.nan {
    didSet {
      configureShadowRadius()
    }
  }

  @IBInspectable open var shadowOpacity: CGFloat = CGFloat.nan {
    didSet {
      configureShadowOpacity()
    }
  }

  @IBInspectable open var shadowOffset: CGPoint = CGPoint(x: CGFloat.nan, y: CGFloat.nan) {
    didSet {
      configureShadowOffset()
    }
  }

  // MARK: - FillDesignable
  @IBInspectable open var fillColor: UIColor? {
    didSet {
      configureFillColor()
    }
  }

  open var predefinedColor: ColorType? {
    didSet {
      configureFillColor()
    }
  }
  @IBInspectable var _predefinedColor: String? {
    didSet {
      predefinedColor = ColorType(string: _predefinedColor)
    }
  }

  @IBInspectable open var opacity: CGFloat = CGFloat.nan {
    didSet {
      configureOpacity()
    }
  }

  // MARK: - BorderDesignable
  open var borderType: BorderType  = .solid {
    didSet {
      configureBorder()
    }
  }

  @IBInspectable var _borderType: String? {
    didSet {
      borderType = BorderType(string: _borderType)
    }
  }

  @IBInspectable open var borderColor: UIColor? {
    didSet {
      configureBorder()
    }
  }

  @IBInspectable open var borderWidth: CGFloat = CGFloat.nan {
    didSet {
      configureBorder()
    }
  }

  open var borderSides: BorderSides  = .AllSides {
    didSet {
      configureBorder()
    }
  }

  @IBInspectable var _borderSides: String? {
    didSet {
      borderSides = BorderSides(rawValue: _borderSides)
    }
  }
  // MARK: - TableViewCellDesignable
  @IBInspectable open var removeSeparatorMargins: Bool = false

  // MARK: - GradientDesignable
  @IBInspectable open var startColor: UIColor?
  @IBInspectable open var endColor: UIColor?
  open var predefinedGradient: GradientType?
  @IBInspectable var _predefinedGradient: String? {
    didSet {
      predefinedGradient = GradientType(string: _predefinedGradient)
    }
  }
  open var startPoint: GradientStartPoint = .top
  @IBInspectable var _startPoint: String? {
    didSet {
      startPoint = GradientStartPoint(string: _startPoint, default: .top)
    }
  }

  // MARK: - BackgroundImageDesignable
  @IBInspectable open var backgroundImage: UIImage? {
    didSet {
      configureBackgroundImage()
    }
  }

  // MARK: - Animatable
  open var animationType: AnimationType = .none
  @IBInspectable  var _animationType: String? {
    didSet {
      animationType = AnimationType(string: _animationType)
    }
  }
  @IBInspectable open var autoRun: Bool = true
  @IBInspectable open var duration: Double = Double.nan
  @IBInspectable open var delay: Double = Double.nan
  @IBInspectable open var damping: CGFloat = CGFloat.nan
  @IBInspectable open var velocity: CGFloat = CGFloat.nan
  @IBInspectable open var force: CGFloat = CGFloat.nan

  // MARK: - Lifecycle
  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configureInspectableProperties()
  }

  open override func awakeFromNib() {
    super.awakeFromNib()
    configureInspectableProperties()
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    configureAfterLayoutSubviews()
    autoRunAnimation()
  }

  // MARK: - Private
  fileprivate func configureInspectableProperties() {
    configureAnimatableProperties()
    configureOpacity()
  }

  fileprivate func configureAfterLayoutSubviews() {
    configureCornerRadius()
    configureBorder()
    configureGradient()
  }
}
