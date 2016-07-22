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

struct BorderSides: OptionSet {
  let rawValue: Int
  
  static let Unknown = BorderSides(rawValue: 0)
  
  static let top = BorderSides(rawValue: 1)
  static let right = BorderSides(rawValue: 1 << 1)
  static let bottom = BorderSides(rawValue: 1 << 2)
  static let left = BorderSides(rawValue: 1 << 3)
  
  static let AllSides: BorderSides = [.top, .right, .bottom, .left]
  
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
    
    let sideElements = rawValue.characters.split(separator: ",")
      .map(String.init)
      .map { BorderSide(rawValue: $0.trimmingCharacters(in: CharacterSet.whitespaces)) }
      .map { BorderSides(side: $0) }
    
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
    case .top: self = .top
    case .right: self = .right
    case .bottom: self = .bottom
    case .left: self = .left
    }
  }
}

public extension BorderDesignable where Self: UITextField {
  public func configBorder() {
    // set the borderSytle to `.None` to support single side of border
    borderStyle = .none
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
    guard let unwrappedBorderColor = borderColor, borderWidth > 0 else {
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
      borderLayer.fillColor = UIColor.clear().cgColor
      borderLayer.strokeColor = unwrappedBorderColor.cgColor
      borderLayer.lineWidth = borderWidth
      borderLayer.frame = bounds
      layer.insertSublayer(borderLayer, at: 0)
      return
    }
    
    let sides = BorderSides(rawValue: borderSide)
    
    if sides == .AllSides {
      layer.borderColor = unwrappedBorderColor.cgColor
      layer.borderWidth = borderWidth
      return
    }
    
    // configure border for specified sides
    let border = CAShapeLayer()
    border.name = "borderSideLayer"
    
    let borderPath = UIBezierPath()
    
    var lines: [(start: CGPoint, end: CGPoint)] = []
    if sides.contains(.top) {
      lines.append((start: .zero, end: CGPoint(x: bounds.size.width, y: 0)))
    }
    if sides.contains(.right) {
      lines.append((start: CGPoint(x: bounds.size.width, y: 0), end: CGPoint(x: bounds.size.width, y: bounds.size.height)))
    }
    if sides.contains(.bottom) {
      lines.append((start: CGPoint(x: 0, y: bounds.size.height), end: CGPoint(x: bounds.size.width, y: bounds.size.height)))
    }
    if sides.contains(.left) {
      lines.append((start: .zero, end: CGPoint(x: 0, y: bounds.size.height)))
    }
    
    for linePoints in lines {
      borderPath.move(to: linePoints.start)
      borderPath.addLine(to: linePoints.end)
    }
    
    border.path = borderPath.cgPath
    border.fillColor = UIColor.clear().cgColor
    border.strokeColor = unwrappedBorderColor.cgColor
    border.lineWidth = borderWidth
    border.frame = bounds
    layer.insertSublayer(border, at: 0)
  }
}
