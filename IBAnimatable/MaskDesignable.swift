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
      switch rawMaskType {
      case .Circle:
        maskCircle()
      case .Star:
        maskStar()
      case .Wave:
        maskWave()
      }
      return
    }
    
    // Mask Star with parameter
    // Mask Wave with parameter
  }
  
  // MARK: - Mask
  
  public func maskCircle() {
    layer.cornerRadius = ceil(min(bounds.width, bounds.height))/2
  }
  
  // See https://www.weheartswift.com/bezier-paths-gesture-recognizers/
  public func maskStar(sides: Int = 5) {
    // FIXME: Do not mask the shadow.
    
    assert(sides >= 2, "Stars must has at least 2 sides.")
    layer.mask?.removeFromSuperlayer()
    layer.sublayers?
      .filter  { $0.name == "borderSideLayer" || $0.name == "borderLayer" }
      .forEach { $0.removeFromSuperlayer() }
    
    let path = starPath(sides)
    let borderPath = starPath(sides, borderWidth: layer.borderWidth).bezierPathByReversingPath()
    drawPath(path)
    drawBorderPath(borderPath, path: path)
  }
  
  public func maskWave(waveUp: Bool = true, waveWidth: CGFloat = 40.0, waveOffset: CGFloat = 0.0) {
    let wavePath = maskWaveBezierPath(waveUp, waveWidth: waveWidth, waveOffset: waveOffset)
    drawPath(wavePath)
  }
  
  // MARK: Private
  
  func drawPath(path: UIBezierPath) {
    let maskLayer = CAShapeLayer()
    maskLayer.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
    maskLayer.path = path.CGPath
    layer.mask = maskLayer
  }
  
  func drawBorderPath(borderPath: UIBezierPath, path: UIBezierPath) {
    // FIXME: borderWidth is always set after mask, so the following code will never be excuted.
    if layer.borderWidth == 0 {
      return
    }
    
    // NOTE: Lex: In order to draw the original border, we need to add a new sublayer.
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
    return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
  }
  
  // MARK: Star
  
  private func starPath(points: Int, borderWidth: CGFloat = 0) -> UIBezierPath {
    let path = UIBezierPath()
    let radius = min(layer.bounds.size.width, layer.bounds.size.height) / 2 - borderWidth
    let starCenter = CGPoint(x: radius, y: radius)
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
  
  // MARK: MaskWave
  
  private func maskWaveBezierPath(waveUp: Bool, waveWidth: CGFloat, waveOffset: CGFloat) -> UIBezierPath {
    let originY = waveUp ? bounds.maxY : bounds.minY
    let halfWidth = waveWidth / 2.0
    let halfHeight = bounds.height / 2.0
    let quarterWidth = waveWidth / 4.0
    
    var up = waveUp
    var startX = bounds.minX - quarterWidth - (waveOffset % waveWidth)
    var endX = startX + halfWidth
    
    let path = UIBezierPath()
    path.moveToPoint(CGPoint(x: startX, y: originY))
    path.addLineToPoint(CGPoint(x: startX, y: bounds.midY))
    
    repeat {
      path.addQuadCurveToPoint(
        CGPoint(x: endX, y: bounds.midY),
        controlPoint: CGPoint(
          x: startX + quarterWidth,
          y: up ? bounds.maxY + halfHeight : bounds.minY - halfHeight)
      )
      startX = endX
      endX += halfWidth
      up = !up
    } while startX < bounds.maxX
    
    path.addLineToPoint(CGPoint(x: path.currentPoint.x, y: originY))    
    return path
  }
  
}
