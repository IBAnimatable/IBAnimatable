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
    } else {
      if unwrappedMaskType.hasPrefix(MaskType.Star.rawValue) {
        maskStarFromString(unwrappedMaskType)
      } else if unwrappedMaskType.hasPrefix(MaskType.Wave.rawValue) {
        maskWaveFromString(unwrappedMaskType)
      } else if unwrappedMaskType.hasPrefix(MaskType.Polygon.rawValue) {
        maskPolygonFromString(unwrappedMaskType)
      }
    }
  }
  
  // MARK: - Circle
  
  private func maskCircle() {
    layer.cornerRadius = ceil(min(bounds.width, bounds.height))/2
  }
  
  // MARK: - Polygon
  
  private func maskPolygonFromString(mask: String) {
    let sides = Int(retrieveMaskParameters(mask, maskName: MaskType.Polygon.rawValue))
    if let unwrappedSides = sides {
      maskPolygon(unwrappedSides)
    } else {
      maskPolygon()
    }
  }
  
  private func maskPolygon(sides: Int = 6) {
    let polygonPath = maskPolygonBezierPath(sides)
    drawPath(polygonPath)
  }

  private func maskPolygonBezierPath(sides: Int) -> UIBezierPath {
    let path = UIBezierPath()
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle: CGFloat = -CGFloat(M_PI / 2.0)
    let angleIncrement = CGFloat(M_PI * 2.0 / Double(sides))
    let radius = bounds.width / 2.0
    
    path.moveToPoint(pointFrom(angle, radius: radius, offset: center))
    for _ in 1...sides - 1 {
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
  
  // See https://www.weheartswift.com/bezier-paths-gesture-recognizers/
  private func maskStar(points: Int = 5) {
    // FIXME: Do not mask the shadow.
    
    // Stars must has at least 3 points.
    var starPoints = points
    if points <= 2 {
      starPoints = 5
    }
    
    let path = starPath(starPoints)
    drawPath(path)
  }
  
  private func starPath(points: Int, borderWidth: CGFloat = 0) -> UIBezierPath {
    let path = UIBezierPath()
    let radius = min(bounds.size.width, bounds.size.height) / 2 - borderWidth
    let starExtrusion = radius / 2
    let angleIncrement = CGFloat(M_PI * 2.0 / Double(points))
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle = -CGFloat(M_PI / 2.0)
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

  private func maskTriangle() {
    let trianglePath = maskTriangleBezierPath()
    drawPath(trianglePath)
  }
  
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
    if let unwrappedWidth = Float(params[1]), unwrappedOffset = Float(params[2]) where params.count == 3 {
      let up = params[0] == "up"
      maskWave(up, waveWidth: CGFloat(unwrappedWidth), waveOffset: CGFloat(unwrappedOffset))
    } else {
      maskWave()
    }
  }
  
  private func maskWave(waveUp: Bool = true, waveWidth: CGFloat = 40.0, waveOffset: CGFloat = 0.0) {
    let wavePath = maskWaveBezierPath(waveUp, waveWidth: waveWidth, waveOffset: waveOffset)
    drawPath(wavePath)
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

  
  // MARK: - Private helper
  
  private func drawPath(path: UIBezierPath) {
    layer.mask?.removeFromSuperlayer()
    
    let maskLayer = CAShapeLayer()
    maskLayer.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
    maskLayer.path = path.CGPath
    layer.mask = maskLayer
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
  
}
