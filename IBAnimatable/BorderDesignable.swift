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
  var borderSide: String? { get set }
  
}

struct BorderSides: OptionSetType {
  let rawValue: Int
  
  static let Unknown = BorderSides(rawValue: 0)
  
  static let Top = BorderSides(rawValue: 1)
  static let Right = BorderSides(rawValue: 1 << 1)
  static let Bottom = BorderSides(rawValue: 1 << 2)
  static let Left = BorderSides(rawValue: 1 << 3)
  
  static let AllSides: BorderSides = [.Top, .Right, .Bottom, .Left]
  
  init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  init(rawValue: String?) {
    guard let rawValue = rawValue else {
      self = .AllSides
      return
    }
    
    guard !rawValue.isEmpty else {
      self = .AllSides
      return
    }
    
    let sideElements = rawValue.characters.split(",")
      .map(String.init)
      .map { BorderSide(rawValue: $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())) }
      .map { BorderSides(side:$0) }
    
    guard !sideElements.contains(.Unknown) else {
      self = .AllSides
      return
    }
    
    self = BorderSides(sideElements)
    
  }
  
  init(side: BorderSide?) {
    guard let side = side else { 
      self = .Unknown 
      return 
    }
    
    switch side {
    case .Top: self = .Top
    case .Right: self = .Right
    case .Bottom: self = .Bottom
    case .Left: self = .Left
    }
  }
}

public extension BorderDesignable where Self: UITextField {
  public func configBorder() {
    // set the borderSytle to `.None` to support single side of border
    borderStyle = .None
    commonConfigBorder()
  }
}

public extension BorderDesignable where Self: UIView {
  public func configBorder() {
    commonConfigBorder()
  }
}

private extension BorderDesignable where Self: UIView {
  func commonConfigBorder() {
    guard let unwrappedBorderColor = borderColor where borderWidth > 0 else {
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
      borderLayer.fillColor = UIColor.clearColor().CGColor
      borderLayer.strokeColor = unwrappedBorderColor.CGColor
      borderLayer.lineWidth = borderWidth
      borderLayer.frame = bounds
      layer.insertSublayer(borderLayer, atIndex: 0)
      return
    }
    
    let sides = BorderSides(rawValue: borderSide)
    
    if sides == .AllSides {
      layer.borderColor = unwrappedBorderColor.CGColor
      layer.borderWidth = borderWidth
      return
    }
    
    // configure border for specified sides
    let border = CAShapeLayer()
    border.name = "borderSideLayer"
    
    let borderPath = UIBezierPath()
    
    var lines:[(start: CGPoint, end: CGPoint)] = []
    if sides.contains(.Top) {
      lines.append((start: .zero, end: CGPoint(x: bounds.size.width, y: 0)))
    }
    if sides.contains(.Right) {
      lines.append((start: CGPoint(x: bounds.size.width, y: 0), end: CGPoint(x: bounds.size.width, y: bounds.size.height)))
    }
    if sides.contains(.Bottom) {
      lines.append((start:CGPoint(x: 0, y: bounds.size.height), end: CGPoint(x: bounds.size.width, y: bounds.size.height)))
    }
    if sides.contains(.Left) {
      lines.append((start: .zero, end: CGPoint(x: 0, y: bounds.size.height)))
    }
    
    for linePoints in lines {
      borderPath.moveToPoint(linePoints.start)
      borderPath.addLineToPoint(linePoints.end)
    }
    
    border.path = borderPath.CGPath
    border.fillColor = UIColor.clearColor().CGColor
    border.strokeColor = unwrappedBorderColor.CGColor
    border.lineWidth = borderWidth
    border.frame = bounds
    layer.insertSublayer(border, atIndex: 0)
  }
}
