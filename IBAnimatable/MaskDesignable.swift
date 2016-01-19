//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol MaskDesignable {
  var maskType: String? { get set }
}

public extension MaskDesignable where Self: UIView {
  public func configMask() {
    guard let unwrappedMaskType = maskType else {
      return
    }
    
    if let rawMaskType = MaskType(rawValue: unwrappedMaskType) {
      switch(rawMaskType) {
      case .Circle:
        maskCircle()
      case .Star:
        maskStar()
      }
      return
    }
    
    // Mask Star with parameter
  }
    
  // MARK: - Private
  private func maskCircle() {
    layer.cornerRadius = ceil(min(bounds.width, bounds.height))/2
  }
  
  // See https://www.weheartswift.com/bezier-paths-gesture-recognizers/
  
  func maskStar(sides: Int = 5) {
    // FIXME: Do not mask the shadow.
    
    assert(sides >= 2, "Stars must has at least 2 sides.")
    layer.mask?.removeFromSuperlayer()
    layer.sublayers?
      .filter  { $0.name == "borderSideLayer" || $0.name == "borderLayer" }
      .forEach { $0.removeFromSuperlayer() }
    
    let path = starPath(sides)
    
    let maskLayer = CAShapeLayer()
    maskLayer.frame = CGRect(origin: CGPointZero, size: bounds.size)
    maskLayer.path = path.CGPath
    layer.mask = maskLayer
    
    // FIXME: borderWidth is always set after mask, so the following code will never be excuted.
    
    if layer.borderWidth == 0 {
      return
    }
    
    // NOTE: Lex: In order to draw the original border, we need to add a new sublayer.
    
    let borderPath = starPath(sides, borderWidth: layer.borderWidth).bezierPathByReversingPath()
    borderPath.appendPath(path)
    
    let borderMaskLayer = CAShapeLayer()
    borderMaskLayer.path = borderPath.CGPath
    
    let borderLayer = CALayer()
    borderLayer.name = "borderLayer"
    borderLayer.bounds = layer.bounds
    borderLayer.mask = borderMaskLayer
    layer.addSublayer(borderLayer)
    borderLayer.backgroundColor = layer.borderColor
    
    // NOTE: Lex: Dismiss the original border of layer.
    layer.borderWidth = 0
  }
  
  private func degree2radian(degree: CGFloat) -> CGFloat {
    let radian = CGFloat(M_PI) * degree / 180
    return radian
  }
  
  private func pointFrom(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
    return CGPointMake(radius * cos(angle) + offset.x, radius * sin(angle) + offset.y)
  }
  
  private func starPath(points: Int, borderWidth: CGFloat = 0) -> UIBezierPath {
    let path = UIBezierPath()
    let radius = min(layer.bounds.size.width, layer.bounds.size.height) / 2 - borderWidth
    let starCenter = CGPointMake(radius, radius)
    let starExtrusion = radius / 2
    
    let angleIncrement = CGFloat(M_PI * 2.0 / Double(points))
    var angle:CGFloat = -CGFloat(M_PI / 2.0)
    
    var firstPoint = true
    
    for _ in 1...points {
      let point = pointFrom(angle, radius: radius, offset: center)
      let nextPoint = pointFrom(angle + angleIncrement, radius: radius, offset: starCenter)
      let midPoint = pointFrom(angle + angleIncrement / 2.0, radius: starExtrusion, offset: starCenter)
      
      if firstPoint {
        firstPoint = false
        path.moveToPoint(point)
      }
      
      path.addLineToPoint(midPoint)
      path.addLineToPoint(nextPoint)
      
      angle += angleIncrement
    }
    
    path.closePath()
    
    
    return path
  }
  
}
