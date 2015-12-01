//
//  TintDesignable.swift
//  IBAnimatableApp
//
//  Created by Jake Lin on 11/24/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol TintDesignable {
  /**
   tinted color
   */
  var tintedColor: UIColor { get set }
  
  /**
   Opacity in tinted view: from 0 to 1
   */
  var tintOpacity: CGFloat { get set }
}

public extension TintDesignable where Self:UIView {
  /**
   configTintedColor method, should be called in layoutSubviews() method
   */
  public func configTintedColor() {
    if (tintedColor != UIColor.clearColor()
      && tintOpacity>0 && tintOpacity<=1) {        
        let subview = UIView(frame: self.frame)
        subview.backgroundColor = tintedColor
        subview.alpha = tintOpacity
        subview.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        self.insertSubview(subview, atIndex: 0)
    }
  }
}
