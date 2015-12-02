//
//  Created by Jake Lin on 12/2/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable public class DesignableGradientView : UIView {
  @IBInspectable var startColor: UIColor = UIColor.clearColor()
  @IBInspectable var endColor: UIColor = UIColor.clearColor()
  @IBInspectable var direction: String = ""
  @IBInspectable var cornerRadius: CGFloat = 0.0
  
  var gradientLayer: CAGradientLayer {
    return layer as! CAGradientLayer
  }
  
  // MARK: - CALayer
  public override class func layerClass() -> AnyClass {
    return CAGradientLayer.self
  }
  
  // MARK: - Life cycle
  public override func prepareForInterfaceBuilder() {
    configGradient()
  }
  
  public override func awakeFromNib() {
    configGradient()
  }
  
  private func configGradient() {
    // Return if both colors are unset.
    if (startColor == UIColor.clearColor() && endColor == UIColor.clearColor()) {
      return
    }
    
    gradientLayer.colors = [startColor.CGColor, endColor.CGColor]
    gradientLayer.cornerRadius = cornerRadius
    gradientLayer.endPoint = CGPoint(x: 1, y: 0)
  }
}