//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable open class AnimatableTextField: UITextField, CornerDesignable, FillDesignable, BorderDesignable, ShadowDesignable, PaddingDesignable, SideImageDesignable, PlaceholderDesignable, Animatable {
 
  // MARK: - CornerDesignable
  @IBInspectable open var cornerRadius: CGFloat = CGFloat.nan {
    didSet {
      configureCornerRadius()
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
  
  // MARK: - PaddingDesignable
  @IBInspectable open var paddingLeft: CGFloat = CGFloat.nan {
    didSet {
      configurePaddingLeft()
    }
  }
  
  @IBInspectable open var paddingRight: CGFloat = CGFloat.nan {
    didSet {
      configurePaddingRight()
    }
  }

  @IBInspectable open var paddingSide: CGFloat = CGFloat.nan {
    didSet {
      configurePaddingSide()
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
      configurePlaceholderColor()
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
    configureImages()
  }
  
  fileprivate func configureAfterLayoutSubviews() {
    configureBorder()
  }
}
