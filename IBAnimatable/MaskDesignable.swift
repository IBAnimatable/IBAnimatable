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
      case .Polygon:
        maskPolygon()
      case .Triangle:
        maskTriangle()
      case .Wave:
        maskWave()
      }
      return
    }
    
    // Star with parameter
    if unwrappedMaskType.hasPrefix(MaskType.Star.rawValue) {
      maskStarFromString(unwrappedMaskType)
      return
    }
  }
  
  // MARK: - Mask
  
  public func maskCircle() {
    layer.cornerRadius = ceil(min(bounds.width, bounds.height))/2
  }
  
  public func maskPolygon() {
    let polygonPath = maskPolygonBezierPath(Int(arc4random_uniform(10) + 3))
    drawPath(polygonPath)
  }
  
  // See https://www.weheartswift.com/bezier-paths-gesture-recognizers/
  public func maskStar(points: Int = 5) {
    // FIXME: Do not mask the shadow.
    
    // Stars must has at least 3 points.
    var starPoints = points
    if points <= 2 {
      starPoints = 5
    }
    layer.mask?.removeFromSuperlayer()
    layer.sublayers?
      .filter  { $0.name == "borderSideLayer" || $0.name == "borderLayer" }
      .forEach { $0.removeFromSuperlayer() }
    
    let path = starPath(starPoints)
    drawPath(path)
  }
  
  public func maskTriangle() {
    let trianglePath = maskTriangleBezierPath()
    drawPath(trianglePath)
  }
    
  public func maskWave(waveUp: Bool = true, waveWidth: CGFloat = 40.0, waveOffset: CGFloat = 0.0) {
    let wavePath = maskWaveBezierPath(waveUp, waveWidth: waveWidth, waveOffset: waveOffset)
    drawPath(wavePath)
  }
  
  // MARK: - Private helper
  
  private func drawPath(path: UIBezierPath) {
    let maskLayer = CAShapeLayer()
    maskLayer.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
    maskLayer.path = path.CGPath
    layer.mask = maskLayer
  }
  
  private func drawBorderPath(borderPath: UIBezierPath, path: UIBezierPath) {
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
  
  private func retrieveMaskParameters(mask: String, maskName: String) -> String {
    var params = mask.stringByReplacingOccurrencesOfString(" ", withString: "")
    params = params.stringByReplacingOccurrencesOfString(maskName, withString: "")
    params = params.stringByReplacingOccurrencesOfString("(", withString: "")
    params = params.stringByReplacingOccurrencesOfString(")", withString: "")
    return params
  }
  
  // MARK: - Polygon
  
  private func maskPolygonBezierPath(degree: Int) -> UIBezierPath {
    let path = UIBezierPath()
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle: CGFloat = -CGFloat(M_PI / 2.0)
    let angleIncrement = CGFloat(M_PI * 2.0 / Double(degree))
    let radius = bounds.width / 2.0
    
    path.moveToPoint(pointFrom(angle, radius: radius, offset: center))
    for _ in 1...degree - 1 {
      angle += angleIncrement
      path.addLineToPoint(pointFrom(angle, radius: radius, offset: center))
    }
    path.closePath()
    return path
  }
  
  // MARK: - Star
  
  private func maskStarFromString(mask: String) {
    let points = Int(retrieveMaskParameters(mask, maskName: MaskType.Star.rawValue))
    if let unwrappedPoints = points {
      maskStar(unwrappedPoints)
    } else {
      maskStar()
    }
  }
  
  private func starPath(points: Int, borderWidth: CGFloat = 0) -> UIBezierPath {
    let path = UIBezierPath()
    let radius = min(layer.bounds.size.width, layer.bounds.size.height) / 2 - borderWidth
    let starExtrusion = radius / 2
    
    let angleIncrement = CGFloat(M_PI * 2.0 / Double(points))
    var angle:CGFloat = -CGFloat(M_PI / 2.0)
    
    var firstPoint = true
    
    for _ in 1...points {
      let point = pointFrom(angle, radius: radius, offset: center)
      let nextPoint = pointFrom(angle + angleIncrement, radius: radius, offset: center)
      let midPoint = pointFrom(angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)
      
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
  
  // MARK: - Triangle

  private func maskTriangleBezierPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.moveToPoint(CGPoint(x: bounds.width / 2.0, y: bounds.origin.y))
    path.addLineToPoint(CGPoint(x: bounds.width, y: bounds.height))
    path.addLineToPoint(CGPoint(x: bounds.origin.x, y: bounds.height))
    path.closePath()
    return path
  }
  
  // MARK: - Wave
  
  private func maskWaveFromString(mask: String) {
    let params = retrieveMaskParameters(mask, maskName: MaskType.Wave.rawValue).componentsSeparatedByString(",")
    if params.count == 3, let unwrappedWidth = Float(params[1]), unwrappedOffset = Float(params[2]) {
        let up = params[0] == "up"
        maskWave(up, waveWidth: CGFloat(unwrappedWidth), waveOffset: CGFloat(unwrappedOffset))
    } else {
        maskWave()
    }
  }
  
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
