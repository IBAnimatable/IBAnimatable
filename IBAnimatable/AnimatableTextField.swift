//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableTextField: UITextField, CornerDesignable, FillDesignable, BorderDesignable, ShadowDesignable, PaddingDesignable, SideImageDesignable, PlaceholderDesignable, Animatable {
 
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
  
  // MARK: - PaddingDesignable
  @IBInspectable public var paddingLeft: CGFloat = CGFloat.NaN {
    didSet {
      configPaddingLeft()
    }
  }
  
  @IBInspectable public var paddingRight: CGFloat = CGFloat.NaN {
    didSet {
      configPaddingRight()
    }
  }

  @IBInspectable public var paddingSide: CGFloat = CGFloat.NaN {
    didSet {
      configPaddingSide()
    }
  }
  
  // MARK: - SideImageDesignable
  @IBInspectable public var leftImage: UIImage? = nil
  @IBInspectable public var leftImageLeftPadding: CGFloat = 0
  @IBInspectable public var leftImageRightPadding: CGFloat = 0
  @IBInspectable public var leftImageTopPadding: CGFloat = CGFloat.NaN

  
  // MARK: - CSSPlaceholderable
  @IBInspectable public var placeholderColor: UIColor = UIColor.clearColor() {
    didSet {
      configPlaceholderColor()
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
    configLeftImage()
  }
}

