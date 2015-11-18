//
//  CSSView.swift
//  IBCSSableApp
//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class CSSView: UIView, CSSable {
  @IBInspectable public var borderColor: UIColor = UIColor.clearColor() {
    didSet {
      layer.borderColor = borderColor.CGColor
    }
  }
  
  @IBInspectable public var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }

  @IBInspectable public var borderRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = borderRadius
      layer.masksToBounds = borderRadius > 0
    }
  }
}
