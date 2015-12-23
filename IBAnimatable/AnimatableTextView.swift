//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableTextView: UITextView, CornerDesignable, FillDesignable, BorderDesignable, Animatable {
  
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
  @IBInspectable public var borderColor: UIColor = UIColor.clearColor()
  @IBInspectable public var borderWidth: CGFloat = 0
  @IBInspectable public var borderSide: String = ""

  // MARK: - Animatable
  @IBInspectable public var animationType: String = ""
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = 0.7
  @IBInspectable public var delay: Double = 0
  @IBInspectable public var force: CGFloat = 1
  @IBInspectable public var damping: CGFloat = 0.7
  @IBInspectable public var velocity: CGFloat = 0.7
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
  }
}
