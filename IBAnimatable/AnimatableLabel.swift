//
//  Created by Jake Lin on 12/20/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable open class AnimatableLabel: UILabel, CornerDesignable, FillDesignable, Animatable, RotationDesignable, BorderDesignable {
  
  // MARK: - CornerDesignable
  @IBInspectable open var cornerRadius: CGFloat = CGFloat.nan {
    didSet {
      configCornerRadius()
    }
  }
  
  // MARK: - FillDesignable
  @IBInspectable open var fillColor: UIColor? {
    didSet {
      configFillColor()
    }
  }
  
  @IBInspectable open var predefinedColor: String? {
    didSet {
      configFillColor()
    }
  }
  
  @IBInspectable open var opacity: CGFloat = CGFloat.nan {
    didSet {
      configOpacity()
    }
  }
  
  // MARK: - BorderDesignable
  @IBInspectable open var borderColor: UIColor? {
    didSet {
      configBorder()
    }
  }
  
  @IBInspectable open var borderWidth: CGFloat = CGFloat.nan {
    didSet {
      configBorder()
    }
  }
  
  open var borderSides: BorderSides  = .AllSides {
    didSet {
      configBorder()
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
  @IBInspectable open var repeatCount: Float = Float.nan
  
  // MARK: - RotationDesignable
  @IBInspectable open var rotate: CGFloat = CGFloat.nan {
    didSet {
      configRotate()
    }
  }
  
  // MARK: - Lifecycle
  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configInspectableProperties()
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    configInspectableProperties()
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    configAfterLayoutSubviews()
    autoRunAnimation()
  }
  
  // MARK: - Private
  fileprivate func configInspectableProperties() {
    configAnimatableProperties()
    configBorder()
  }
  
  fileprivate func configAfterLayoutSubviews() {
    configBorder()
  }
}
