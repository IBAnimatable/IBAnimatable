//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableButton: UIButton, CornerDesignable, FillDesignable, BorderDesignable, ShadowDesignable, MaskDesignable, Animatable {
  
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
  @IBInspectable public var shadowColor: UIColor? {
    didSet {
      configShadowColor()
    }
  }

  @IBInspectable public var shadowRadius: CGFloat = CGFloat.NaN {
    didSet {
      configShadowRadius()
    }
  }

  @IBInspectable public var shadowOpacity: CGFloat = CGFloat.NaN {
    didSet {
      configShadowOpacity()
    }
  }

  @IBInspectable public var shadowOffset: CGPoint = CGPoint(x: CGFloat.NaN, y: CGFloat.NaN) {
    didSet {
      configShadowOffset()
    }
  }
  
  // MARK: - MaksDesignable
  @IBInspectable public var maskType: String? {
    didSet {
      configMask()
    }
  }
  
  // MARK: - Animatable
  @IBInspectable public var animationType: String?
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = Double.NaN
  @IBInspectable public var delay: Double = Double.NaN
  @IBInspectable public var damping: CGFloat = CGFloat.NaN
  @IBInspectable public var velocity: CGFloat = CGFloat.NaN
  @IBInspectable public var force: CGFloat = CGFloat.NaN
  @IBInspectable public var repeatCount: Float = Float.NaN
  
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
    
    autoRunAnimation()
  }
  
  // MARK: - Private
  private func configInspectableProperties() {
    configAnimatableProperites()
    configBorder()
  }
}
