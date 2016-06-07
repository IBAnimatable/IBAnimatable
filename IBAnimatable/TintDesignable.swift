//
//  Created by Jake Lin on 11/24/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol TintDesignable {
  /**
   Opacity in tint Color (White): from 0 to 1
   */
  var tintOpacity: CGFloat { get set }
  
  
  /**
   Opacity in shade Color (Black): from 0 to 1
   */
  var shadeOpacity: CGFloat { get set }
  
  /**
   tone color
   */
  var toneColor: UIColor? { get set }
  
  /**
   Opacity in tone color: from 0 to 1
   */
  var toneOpacity: CGFloat { get set }
}

public extension TintDesignable where Self: UIView {
  /**
   configTintedColor method, should be called in layoutSubviews() method
   */
  public func configTintedColor() {
    if !tintOpacity.isNaN && tintOpacity >= 0 && tintOpacity <= 1 {
      addColorSubview(UIColor.whiteColor(), opacity: tintOpacity)
    }
    
    if !shadeOpacity.isNaN && shadeOpacity >= 0 && shadeOpacity <= 1 {
      addColorSubview(UIColor.blackColor(), opacity: shadeOpacity)
    }
    
    if let unwrappedToneColor = toneColor {
      if !toneOpacity.isNaN && toneOpacity >= 0 && toneOpacity <= 1 {
        addColorSubview(unwrappedToneColor, opacity: toneOpacity)
      }
    }
  }
  
  private func addColorSubview(color: UIColor, opacity: CGFloat) {
    let subview = UIView(frame: self.bounds)
    subview.backgroundColor = color
    subview.alpha = opacity
    if layer.cornerRadius > 0 {
      subview.layer.cornerRadius = layer.cornerRadius
    }
    subview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    self.insertSubview(subview, atIndex: 0)
  }
}
