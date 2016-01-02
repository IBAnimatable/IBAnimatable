//
//  Created by Jake Lin on 11/23/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol BlurDesignable {
  /**
   blur effect style: `ExtraLight`, `Light` or `Dark`
   */
  var blurEffectStyle: String? { get set }
  
  var blurOpacity: Double? { get set }
}

public extension BlurDesignable where Self: UIView {
  /**
   configBlurEffectStyle method, should be called in layoutSubviews() method
   */
  public func configBlurEffectStyle() {
    guard let unwrappedBlurEffectStyle = blurEffectStyle else {
      return
    }
    
    var style: UIBlurEffectStyle?
    guard let blurEffectStyle = BlurEffectStyle(rawValue: unwrappedBlurEffectStyle) else {
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
    print(blurOpacity)
    let opacity = blurOpacity ?? 1.0 // Default is 1.0
    blurEffectView.alpha = CGFloat(opacity)
    print(blurEffectView.alpha)
    if (layer.cornerRadius > 0) {
      blurEffectView.layer.cornerRadius = layer.cornerRadius
      blurEffectView.clipsToBounds = true
    }
    blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    insertSubview(blurEffectView, atIndex: 0)
  }
}