//
//  Created by Jake Lin on 12/20/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable
open class AnimatableLabel: UILabel, CornerDesignable, FillDesignable, Animatable, RotationDesignable, BorderDesignable {

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
  @IBInspectable var _timingFunction: String = "" {
    didSet {
      timingFunction = TimingFunctionType(string: _timingFunction)
    }
  }
  open var timingFunction: TimingFunctionType = .none

  // MARK: - RotationDesignable
  @IBInspectable open var rotate: CGFloat = CGFloat.nan {
    didSet {
      configureRotate()
    }
  }

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
    configureBorder()
  }

  fileprivate func configureAfterLayoutSubviews() {
    configureCornerRadius()
    configureBorder()
  }
}
