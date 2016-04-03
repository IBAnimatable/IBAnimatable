//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol BorderDesignable {
  /**
    `border-color`, border color
  */
  var borderColor: UIColor? { get set }

  /**
   `border-width`, border width
   */
  var borderWidth: CGFloat { get set }
  
  /**
   border side: Top, Right, Bottom or Left, if not specified, all border sides will display,
   */
  var borderSide: String? { get set }
  
}

public extension BorderDesignable where Self: UIView {
  public func configBorder() {
    func clearBorders() {
      layer.sublayers?.filter  { $0.name == "borderSideLayer" || $0.name == "borderAllSides" }
        .forEach { $0.removeFromSuperlayer() }      
    }
    
    guard let unwrappedBorderColor = borderColor else {
      clearBorders()
      return
    }
    
    if borderWidth.isNaN || borderWidth <= 0 {
      clearBorders()
      return
    }
    
    clearBorders()
    
    if let unwrappedBorderSide = borderSide, side = BorderSide(rawValue: unwrappedBorderSide) {
      configBorderWithSide(side, borderColor: unwrappedBorderColor)
    } else {
      configBorderForAllSides(unwrappedBorderColor)
    }
  }
  
  private func configBorderWithSide(side: BorderSide, borderColor: UIColor) {
    let border = CALayer()
    border.name = "borderSideLayer"
    border.backgroundColor = borderColor.CGColor
    
    switch side {
    case .Top:
      border.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: borderWidth)
    case .Right:
      border.frame = CGRect(x: bounds.size.width - borderWidth, y: 0, width: borderWidth, height: bounds.size.height)
    case .Bottom:
      border.frame = CGRect(x: 0, y: bounds.size.height - borderWidth, width: bounds.size.width, height: borderWidth)
    case .Left:
      border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: bounds.size.height)
    }
    layer.addSublayer(border)
  }

  private func configBorderForAllSides(borderColor: UIColor) {
    if let mask = layer.mask as? CAShapeLayer {
      let borderLayer = CAShapeLayer()
      borderLayer.name = "borderAllSides"
      borderLayer.path = mask.path
      borderLayer.fillColor = UIColor.clearColor().CGColor
      borderLayer.strokeColor = borderColor.CGColor
      borderLayer.lineWidth = borderWidth
      borderLayer.frame = bounds
      layer.insertSublayer(borderLayer, atIndex: 0)
      layer.borderWidth = 0
    } else {
      layer.borderColor = borderColor.CGColor
      layer.borderWidth = borderWidth
    }
  }
}
