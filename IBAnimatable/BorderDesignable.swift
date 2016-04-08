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
      layer.borderColor = nil
      layer.borderWidth = 0
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
    
    guard let unwrappedBorderSide = borderSide else {
      configBorderForAllSides(unwrappedBorderColor)
      return
    }
    
    let sides = BorderSides(rawValue: unwrappedBorderSide)
    guard sides != .None else { return }
    
    configBorderWithSides(sides, borderColor: unwrappedBorderColor)
  }
  
  private func configBorderWithSides(sides: BorderSides, borderColor: UIColor) {
    let border = CAShapeLayer()
    border.name = "borderSideLayer"
    
    let borderPath = UIBezierPath()
    
    var lines:[(start: CGPoint, end: CGPoint)] = []
    if sides.contains(.Top) {
      lines.append((start: CGPoint(x: 0, y: 0), end: CGPoint(x: bounds.size.width, y: 0)))
    }
    if sides.contains(.Right) {
      lines.append((start: CGPoint(x: bounds.size.width, y: 0), end: CGPoint(x: bounds.size.width, y: bounds.size.height)))
    }
    if sides.contains(.Bottom) {
      lines.append((start:CGPoint(x: 0, y: bounds.size.height), end: CGPoint(x: bounds.size.width, y: bounds.size.height)))
    }
    if sides.contains(.Left) {
      lines.append((start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: bounds.size.height)))
    }
    
    for linePoints in lines {
      borderPath.moveToPoint(linePoints.start)
      borderPath.addLineToPoint(linePoints.end)
    }
    
    border.path = borderPath.CGPath;
    border.fillColor = UIColor.clearColor().CGColor
    border.strokeColor = borderColor.CGColor
    border.lineWidth = borderWidth
    border.frame = bounds
    layer.insertSublayer(border, atIndex: 0)
    layer.borderWidth = 0
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
