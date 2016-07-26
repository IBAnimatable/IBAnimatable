//
//  Created by Tom Baranes on 25/06/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableSlider: UIView, BorderDesignable, RotationDesignable, ShadowDesignable, Animatable {

  // MARK: - BorderDesignable
  @IBInspectable public var borderColor: UIColor? {
    didSet {
      configBorder()
    }
  }

  @IBInspectable public var borderWidth: CGFloat = CGFloat.NaN {
    didSet {
      configBorder()
    }
  }

  @IBInspectable public var borderSide: String? {
    didSet {
      configBorder()
    }
  }

  // MARK: - RotationDesignable
  @IBInspectable public var rotate: CGFloat = CGFloat.NaN {
    didSet {
      configRotate()
    }
  }

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

  // MARK: - Animatable
  @IBInspectable public var animationType: String?
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = Double.NaN
  @IBInspectable public var delay: Double = Double.NaN
  @IBInspectable public var damping: CGFloat = CGFloat.NaN
  @IBInspectable public var velocity: CGFloat = CGFloat.NaN
  @IBInspectable public var force: CGFloat = CGFloat.NaN
  @IBInspectable public var repeatCount: Float = Float.NaN
  @IBInspectable public var x: CGFloat = CGFloat.NaN
  @IBInspectable public var y: CGFloat = CGFloat.NaN

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
  }

  private func configAfterLayoutSubviews() {
    configBorder()
  }
}
