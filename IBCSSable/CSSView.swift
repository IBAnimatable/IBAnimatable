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
      configBorderColor()
    }
  }
  
  @IBInspectable public var borderWidth: CGFloat = 0 {
    didSet {
      configBorderWidth()
    }
  }

  @IBInspectable public var borderRadius: CGFloat = 0 {
    didSet {
      configBorderRadius()
    }
  }
}
