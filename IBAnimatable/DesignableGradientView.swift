//
//  Created by Jake Lin on 12/2/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable public class DesignableGradientView: UIView {
  @IBInspectable var startColor: UIColor = UIColor.clearColor()
  @IBInspectable var endColor: UIColor = UIColor.clearColor()
  @IBInspectable var startPoint: String = "Top"
  @IBInspectable var cornerRadius: CGFloat = 0.0
  
  var gradientLayer: CAGradientLayer {
    return layer as! CAGradientLayer
  }
  
  // MARK: - CALayer
  public override class func layerClass() -> AnyClass {
    return CAGradientLayer.self
  }
  
  // MARK: - Lifecycle
  public override func prepareForInterfaceBuilder() {
    configGradient()
  }
  
  public override func awakeFromNib() {
    configGradient()
  }
  
  // MARK: - Internal
  func configGradient() {
    // Return if both colors are unset.
    if (startColor == UIColor.clearColor() && endColor == UIColor.clearColor()) {
      return
    }
    
    guard let gradientStartPoint = GradientStartPoint(rawValue: startPoint) else {
      return
    }
    
    gradientLayer.colors = [startColor.CGColor, endColor.CGColor]
    gradientLayer.cornerRadius = cornerRadius
    switch (gradientStartPoint) {
    case .Top:
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    case .TopRight:
      gradientLayer.startPoint = CGPoint(x: 1, y: 0)
      gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    case .Right:
      gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
    case .BottomRight:
      gradientLayer.startPoint = CGPoint(x: 1, y: 1)
      gradientLayer.endPoint = CGPoint(x: 0, y: 0)
    case .Bottom:
      gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
      gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
    case .BottomLeft:
      gradientLayer.startPoint = CGPoint(x: 0, y: 1)
      gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    case .Left:
      gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
    case .TopLeft:
      gradientLayer.startPoint = CGPoint(x: 0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }
  }
}