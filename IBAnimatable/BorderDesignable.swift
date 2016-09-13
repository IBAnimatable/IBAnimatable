//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
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
  var borderSides: BorderSides { get set }
  
}

public extension BorderDesignable where Self: UITextField {
  public func configureBorder() {
    // set the borderSytle to `.None` to support single side of border
    borderStyle = .none
    commonConfigBorder()
  }
}

public extension BorderDesignable where Self: UIView {
  public func configureBorder() {
    commonConfigBorder()
  }
}

private extension BorderDesignable where Self: UIView {
  func commonConfigBorder() {
    guard let borderColor = borderColor, borderWidth > 0 else {
      return
    }
    
    // Clear borders
    layer.borderColor = nil
    layer.borderWidth = 0
    layer.sublayers?.filter { $0.name == "borderSideLayer" || $0.name == "borderAllSides" }
      .forEach { $0.removeFromSuperlayer() }
    
    // if a layer mask is specified, only border the mask
    if let mask = layer.mask as? CAShapeLayer {
      let borderLayer = CAShapeLayer()
      borderLayer.name = "borderAllSides"
      borderLayer.path = mask.path
      borderLayer.fillColor = UIColor.clear.cgColor
      borderLayer.strokeColor = borderColor.cgColor
      borderLayer.lineWidth = borderWidth
      borderLayer.frame = bounds
      layer.insertSublayer(borderLayer, at: 0)
      return
    }
    
    //let sides = BorderSides(rawValue: BorderSides)
    
    if borderSides == .AllSides {
      layer.borderColor = borderColor.cgColor
      layer.borderWidth = borderWidth
      return
    }
    
    // configure border for specified sides
    let border = CAShapeLayer()
    border.name = "borderSideLayer"
    
    let borderPath = UIBezierPath()
    let shift = borderWidth / 2
    var lines: [(start: CGPoint, end: CGPoint)] = []
    if borderSides.contains(.top) {
      lines.append((start: CGPoint(x: 0, y: shift), end: CGPoint(x: bounds.size.width, y: shift)))
    }
    if borderSides.contains(.right) {
      lines.append((start: CGPoint(x: bounds.size.width - shift, y: 0), end: CGPoint(x: bounds.size.width - shift, y: bounds.size.height)))
    }
    if borderSides.contains(.bottom) {
      lines.append((start: CGPoint(x: 0, y: bounds.size.height - shift), end: CGPoint(x: bounds.size.width, y: bounds.size.height - shift)))
    }
    if borderSides.contains(.left) {
      lines.append((start: CGPoint(x: shift, y: 0), end: CGPoint(x: shift, y: bounds.size.height)))
    }
    
    for linePoints in lines {
      borderPath.move(to: linePoints.start)
      borderPath.addLine(to: linePoints.end)
    }
    
    border.path = borderPath.cgPath
    border.fillColor = UIColor.clear.cgColor
    border.strokeColor = borderColor.cgColor
    border.lineWidth = borderWidth
    border.frame = bounds
    layer.insertSublayer(border, at: 0)
  }
}
