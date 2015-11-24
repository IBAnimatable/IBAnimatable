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
  public func configTintedColor() {
    let tintedView = UIView()
    tintedView.backgroundColor = tintedColor
    tintedView.alpha = tintOpacity
    tintedView.frame = bounds
    insertSubview(tintedView, atIndex: 0)
  }
}
