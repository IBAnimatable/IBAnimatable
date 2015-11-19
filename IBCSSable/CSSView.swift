//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class CSSView: UIView, CSSBorderable, CSSBoxShadowable, CSSAnimatable {
  
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
  
  // MARK: - CSSAnimatable
  
  // Doesn't support animation in IB
  // @IBInspectable public var animationPreview: Bool = false {
  //   didSet {
  //     print(animationPreview)
  //     animate()
  //   }
  // }
  
  @IBInspectable public var animationType: String = AnimationType.BounceLeft.rawValue {
    didSet {
    }
  }
  
  @IBInspectable public var duration: CGFloat = 0 {
    didSet {
    }
  }
  
  @IBInspectable public var delay: CGFloat = 0 {
    didSet {
    }
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    animate()
  }
}
