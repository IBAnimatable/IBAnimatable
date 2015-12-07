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
  var toneColor: UIColor { get set }
  
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
    if (tintOpacity > 0 && tintOpacity <= 1) {
      addColorView(UIColor.whiteColor(), opacity: tintOpacity)
    }
    
    if (shadeOpacity > 0 && shadeOpacity <= 1) {
      addColorView(UIColor.blackColor(), opacity: shadeOpacity)
    }
    
    if (toneColor != UIColor.clearColor()
      && toneOpacity > 0 && toneOpacity <= 1) {
      addColorView(toneColor, opacity: toneOpacity)
    }
  }
  
  private func addColorView(color: UIColor, opacity: CGFloat) {
    let subview = UIView(frame: self.bounds)
    subview.backgroundColor = color
    subview.alpha = opacity
    if (layer.cornerRadius > 0) {
      subview.layer.cornerRadius = layer.cornerRadius
    }
    subview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    self.insertSubview(subview, atIndex: 0)
  }
}
