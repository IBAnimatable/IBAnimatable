//
//  Created by Jake Lin on 11/23/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol BlurDesignable {
  /**
   blur effect style: `ExtraLight`, `Light` or `Dark`
   */
  var blurEffectStyle: String { get set }
  
  var blurOpacity: CGFloat { get set }
}

public extension BlurDesignable where Self: UIView {
  /**
   configBlurEffectStyle method, should be called in layoutSubviews() method
   */
  public func configBlurEffectStyle() {
    var style: UIBlurEffectStyle?
    guard let blurEffectStyle = BlurEffectStyle(rawValue: blurEffectStyle) else {
      return
    }
    
    switch blurEffectStyle {
    case .ExtraLight:
      style = .ExtraLight
    case .Light:
      style = .Light
    case .Dark:
      style = .Dark
    }
    
    let blurEffect = UIBlurEffect(style: style!)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = bounds
    blurEffectView.alpha = blurOpacity
    if (layer.cornerRadius > 0) {
      blurEffectView.layer.cornerRadius = layer.cornerRadius
      blurEffectView.clipsToBounds = true
    }
    blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    insertSubview(blurEffectView, atIndex: 0)
  }
}