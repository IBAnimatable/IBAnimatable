//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableTextField: UITextField, CornerDesignable, FillDesignable, BorderDesignable, ShadowDesignable, PaddingDesignable, SideImageDesignable, PlaceholderDesignable, Animatable {
 
  // MARK: - CornerDesignable
  @IBInspectable public var cornerRadius: CGFloat = 0 {
    didSet {
      configCornerRadius()
    }
  }
  
  // MARK: - FillDesignable
  @IBInspectable public var fillColor: UIColor = UIColor.whiteColor() {
    didSet {
      configFillColor()
    }
  }
  
  @IBInspectable public var opacity: CGFloat = 1 {
    didSet {
      configOpacity()
    }
  }
  
  // MARK: - BorderDesignable
  @IBInspectable public var borderColor: UIColor = UIColor.clearColor() {
    didSet {
      configBorderColor()
    }
  }
  
  @IBInspectable public var borderWidth: CGFloat = 0 {
    didSet {
      configBorderWidth()
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
  
  // MARK: - PaddingDesignable
  @IBInspectable public var paddingLeft: CGFloat = 0 {
    didSet {
      configPaddingLeft()
    }
  }
  
  @IBInspectable public var paddingRight: CGFloat = 0 {
    didSet {
      configPaddingRight()
    }
  }

  @IBInspectable public var paddingSide: CGFloat = 0 {
    didSet {
      configPaddingSide()
    }
  }
  
  // MARK: - SideImageDesignable
  @IBInspectable public var leftImage: String = ""
  @IBInspectable public var leftImagePaddingLeft: CGFloat = 0
  @IBInspectable public var leftImagePaddingRight: CGFloat = 0

  
  // MARK: - CSSPlaceholderable
  @IBInspectable public var placeholderColor: UIColor = UIColor.clearColor() {
    didSet {
      configPlaceholderColor()
    }
  }
  
  // MARK: - Animatable
  @IBInspectable public var animationType: String = ""
  @IBInspectable public var duration: Double = 0.7
  @IBInspectable public var delay: Double = 0
  @IBInspectable public var force: CGFloat = 1
  @IBInspectable public var damping: CGFloat = 0.7
  @IBInspectable public var velocity: CGFloat = 0.7
  @IBInspectable public var repeatCount: Float = 1
  
  // MARK: - Lifecycle
  public override func prepareForInterfaceBuilder() {
    configDesignableProperties()
  }
  
  public override func awakeFromNib() {
    configDesignableProperties()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    startAnimation()
  }
  
  // MARK: - Private
  private func configDesignableProperties() {
    configLeftImage()
  }
}

