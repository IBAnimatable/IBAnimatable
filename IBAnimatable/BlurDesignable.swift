//
//  Blurable.swift
//  IBAnimatableApp
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
}

public extension BlurDesignable where Self:UIView {
  /**
   configBlurEffectStyle method, should be called in layoutSubviews() method
   */
  public func configBlurEffectStyle() {
    var style: UIBlurEffectStyle?
    switch blurEffectStyle {
    case "ExtraLight":
      style = .ExtraLight
    case "Light":
      style = .Light
    case "Dark":
      style = .Dark
    default:
      break
    }
    
    guard let unrappedStyle = style else {
      return
    }
    
    let blurEffect = UIBlurEffect(style: unrappedStyle)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = bounds
    insertSubview(blurEffectView, atIndex: 0)
  }
}