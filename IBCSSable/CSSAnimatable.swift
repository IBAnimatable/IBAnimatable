//
//  CSSAnimatable.swift
//  IBCSSableApp
//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol CSSAnimatable {
  var animationType: AnimationType { get set }
  var animationDuration: CGFloat { get set }
  var animationDelay: CGFloat { get set }
  
  func animate()
}

public extension CSSAnimatable where Self: UIView {
  func animate() {
    
  }
}
