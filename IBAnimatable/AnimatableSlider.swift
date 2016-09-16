//
//  Created by Tom Baranes on 25/06/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable open class AnimatableSlider: UIView, BorderDesignable, RotationDesignable, ShadowDesignable, Animatable {
  
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
  // MARK: - RotationDesignable
  @IBInspectable open var rotate: CGFloat = CGFloat.nan {
    didSet {
      configureRotate()
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
  }
  
  fileprivate func configureAfterLayoutSubviews() {
    configureBorder()
  }
}
