//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable open class AnimatableTextField: UITextField, CornerDesignable, FillDesignable, BorderDesignable, ShadowDesignable, PaddingDesignable, SideImageDesignable, PlaceholderDesignable, Animatable {
 
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
  // MARK: - ShadowDesignable
  @IBInspectable open var shadowColor: UIColor? {
    didSet {
      configShadowColor()
    }
  }
  
  @IBInspectable open var shadowRadius: CGFloat = CGFloat.nan {
    didSet {
      configShadowRadius()
    }
  }
  
  @IBInspectable open var shadowOpacity: CGFloat = CGFloat.nan {
    didSet {
      configShadowOpacity()
    }
  }
  
  @IBInspectable open var shadowOffset: CGPoint = CGPoint(x: CGFloat.nan, y: CGFloat.nan) {
    didSet {
      configShadowOffset()
    }
  }
  
  // MARK: - PaddingDesignable
  @IBInspectable open var paddingLeft: CGFloat = CGFloat.nan {
    didSet {
      configPaddingLeft()
    }
  }
  
  @IBInspectable open var paddingRight: CGFloat = CGFloat.nan {
    didSet {
      configPaddingRight()
    }
  }

  @IBInspectable open var paddingSide: CGFloat = CGFloat.nan {
    didSet {
      configPaddingSide()
    }
  }
  
  // MARK: - SideImageDesignable
  @IBInspectable open var leftImage: UIImage? = nil
  @IBInspectable open var leftImageLeftPadding: CGFloat = CGFloat.nan
  @IBInspectable open var leftImageRightPadding: CGFloat = CGFloat.nan
  @IBInspectable open var leftImageTopPadding: CGFloat = CGFloat.nan

  @IBInspectable open var rightImage: UIImage? = nil
  @IBInspectable open var rightImageLeftPadding: CGFloat = CGFloat.nan
  @IBInspectable open var rightImageRightPadding: CGFloat = CGFloat.nan
  @IBInspectable open var rightImageTopPadding: CGFloat = CGFloat.nan
  
  // MARK: - CSSPlaceholderable
  @IBInspectable open var placeholderColor: UIColor? {
    didSet {
      configPlaceholderColor()
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
    configImages()
  }
  
  fileprivate func configAfterLayoutSubviews() {
    configBorder()
  }
}
