//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableView: UIView, BorderDesignable, BoxShadowDesignable, Slidable {
  
  // MARK: - CSSBorderable
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

  @IBInspectable public var borderRadius: CGFloat = 0 {
    didSet {
      configBorderRadius()
    }
  }
  
  // MARK: - CSSBoxShadowable
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
  
  // MARK: - Animatable
  
  // Doesn't support animation in IB
  // @IBInspectable public var animationPreview: Bool = false {
  //   didSet {
  //     print(animationPreview)
  //     animate()
  //   }
  // }
  
  @IBInspectable public var animationType: String = ""
  @IBInspectable public var duration: Double = 0.7
  @IBInspectable public var delay: Double = 0
  @IBInspectable public var force: CGFloat = 1
  @IBInspectable public var damping: CGFloat = 0.7
  @IBInspectable public var velocity: CGFloat = 0.7
  
  // MARK: - PositionAnimatable
  
  // Doesn't support animation in IB
  // @IBInspectable public var animationPreview: Bool = false {
  //   didSet {
  //     print(animationPreview)
  //     animate()
  //   }
  // }
  
  @IBInspectable public var x: CGFloat = 0
  @IBInspectable public var y: CGFloat = 0
  
  
  
  // MARK: - Life cycle
  public override func layoutSubviews() {
    super.layoutSubviews()
    customLayoutSubviews()
  }
}
