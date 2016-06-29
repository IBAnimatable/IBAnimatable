//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableTextField: UITextField, CornerDesignable, FillDesignable, BorderDesignable, ShadowDesignable, PaddingDesignable, SideImageDesignable, PlaceholderDesignable, Animatable {
 
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
  
  // MARK: - PaddingDesignable
  @IBInspectable public var paddingLeft: CGFloat = CGFloat.nan {
    didSet {
      configPaddingLeft()
    }
  }
  
  @IBInspectable public var paddingRight: CGFloat = CGFloat.nan {
    didSet {
      configPaddingRight()
    }
  }

  @IBInspectable public var paddingSide: CGFloat = CGFloat.nan {
    didSet {
      configPaddingSide()
    }
  }
  
  // MARK: - SideImageDesignable
  @IBInspectable public var leftImage: UIImage? = nil
  @IBInspectable public var leftImageLeftPadding: CGFloat = CGFloat.nan
  @IBInspectable public var leftImageRightPadding: CGFloat = CGFloat.nan
  @IBInspectable public var leftImageTopPadding: CGFloat = CGFloat.nan

  @IBInspectable public var rightImage: UIImage? = nil
  @IBInspectable public var rightImageLeftPadding: CGFloat = CGFloat.nan
  @IBInspectable public var rightImageRightPadding: CGFloat = CGFloat.nan
  @IBInspectable public var rightImageTopPadding: CGFloat = CGFloat.nan
  
  // MARK: - CSSPlaceholderable
  @IBInspectable public var placeholderColor: UIColor? {
    didSet {
      configPlaceholderColor()
    }
  }
  
  // MARK: - Animatable
  @IBInspectable public var animationType: String?
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = Double.nan
  @IBInspectable public var delay: Double = Double.nan
  @IBInspectable public var damping: CGFloat = CGFloat.nan
  @IBInspectable public var velocity: CGFloat = CGFloat.nan
  @IBInspectable public var force: CGFloat = CGFloat.nan
  @IBInspectable public var repeatCount: Float = Float.nan
  @IBInspectable public var x: CGFloat = CGFloat.nan
  @IBInspectable public var y: CGFloat = CGFloat.nan
  
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
    configImages()
  }
  
  private func configAfterLayoutSubviews() {
    configBorder()
  }
}
