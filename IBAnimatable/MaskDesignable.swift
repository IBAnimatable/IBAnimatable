//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol MaskDesignable {
  var maskType: MaskType { get set }
}

public extension MaskDesignable where Self: UIView {
  
  public func configMask() {
    
    switch maskType {
    case .circle:
      maskCircle()
    case .parallelogram(let angle):
      maskParallelogram(angle ?? 60)
    case .polygon(let sides):
      maskPolygon(sides ?? 6)
    case .star(let points):
      maskStar(points ?? 5)
    case .wave(let direction, let width, let offset):
      maskWave(direction ?? .up, waveWidth: width ?? 40.0, waveOffset:offset ?? 0.0)
    case .triangle:
      maskTriangle()
    case .none:
      return
    }
  }
  
  // MARK: - Circle
  
  
  private func maskCircle() {
    let diameter = ceil(min(bounds.width, bounds.height))
    let origin = CGPoint(x: (bounds.width - diameter) / 2.0, y: (bounds.height - diameter) / 2.0)
    let size = CGSize(width: diameter, height: diameter)
    let circlePath = UIBezierPath(ovalIn: CGRect(origin: origin, size: size))
    drawPath(circlePath)
  }
  
  // MARK: - Polygon
  
  private func maskPolygon(_ sides: Int) {
    let polygonPath = maskPolygonBezierPath(max(sides, 3))
    drawPath(polygonPath)
  }
  
  private func maskPolygonBezierPath(_ sides: Int) -> UIBezierPath {
    let path = UIBezierPath()
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle: CGFloat = -.pi / 2
    let angleIncrement = .pi * 2 / CGFloat(sides)
    let length = min(bounds.width, bounds.height)
    let radius = length / 2.0
    
    path.move(to: pointFrom(angle, radius: radius, offset: center))
    for _ in 1...sides - 1 {
      angle += angleIncrement
      path.addLine(to: pointFrom(angle, radius: radius, offset: center))
    }
    path.close()
    return path
  }
  
  // MARK: - Star
  
  // See https://www.weheartswift.com/bezier-paths-gesture-recognizers/
  private func maskStar(_ points: Int) {
    // FIXME: Do not mask the shadow.
    
    // Stars must has at least 3 points.
    var starPoints = points
    if points <= 2 {
      starPoints = 5
    }
    
    let path = starPath(starPoints)
    drawPath(path)
  }
  
  private func starPath(_ points: Int, borderWidth: CGFloat = 0) -> UIBezierPath {
    let path = UIBezierPath()
    let radius = min(bounds.size.width, bounds.size.height) / 2 - borderWidth
    let starExtrusion = radius / 2
    let angleIncrement = .pi * 2 / CGFloat(points)
    let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    var angle: CGFloat = -.pi / 2
    var firstPoint = true
    for _ in 1...points {
      let point = pointFrom(angle, radius: radius, offset: center)
      let nextPoint = pointFrom(angle + angleIncrement, radius: radius, offset: center)
      let midPoint = pointFrom(angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)
      
      if firstPoint {
        firstPoint = false
        path.move(to: point)
      }
      
      path.addLine(to: midPoint)
      path.addLine(to: nextPoint)
      angle += angleIncrement
    }
    
    path.close()
    return path
  }
  
  // MARK: - Parallelogram
  
  private func maskParallelogram(_ topLeftAngle: Double) {
    let parallelogramPath = maskParallelogramBezierPath(topLeftAngle)
    drawPath(parallelogramPath)
  }
  
  private func maskParallelogramBezierPath(_ topLeftAngle: Double) -> UIBezierPath {
    let topLeftAngleRad = topLeftAngle * .pi / 180
    let path = UIBezierPath()
    let offset = abs(CGFloat(tan(topLeftAngleRad - .pi / 2)) * bounds.height)
    
    if topLeftAngle <= 90 {
      path.move(to: CGPoint(x:0, y:0))
      path.addLine(to: CGPoint(x: bounds.width - offset, y: 0))
      path.addLine(to: CGPoint(x:bounds.width, y:bounds.height))
      path.addLine(to: CGPoint(x: offset, y: bounds.height))
    } else {
      path.move(to: CGPoint(x:offset, y:0))
      path.addLine(to: CGPoint(x:bounds.width, y:0))
      path.addLine(to: CGPoint(x:bounds.width - offset, y:bounds.height))
      path.addLine(to: CGPoint(x:0, y:bounds.height))
    }
    path.close()
    return path
  }
  
  // MARK: - Triangle
  
  private func maskTriangle() {
    let trianglePath = maskTriangleBezierPath()
    drawPath(trianglePath)
  }
  
  private func maskTriangleBezierPath() -> UIBezierPath {
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x: bounds.width / 2.0, y: bounds.origin.y))
    path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
    path.addLine(to: CGPoint(x: bounds.origin.x, y: bounds.height))
    path.close()
    return path
  }
  
  // MARK: - Wave
  
  
  private func maskWave(_ waveDirection: MaskType.WaveDirection, waveWidth: Float , waveOffset: Float) {
    let wavePath = maskWaveBezierPath(waveDirection == .up, waveWidth: CGFloat(waveWidth), waveOffset: CGFloat(waveOffset))
    drawPath(wavePath)
  }
  
  private func maskWaveBezierPath(_ waveUp: Bool, waveWidth: CGFloat, waveOffset: CGFloat) -> UIBezierPath {
    let originY = waveUp ? bounds.maxY : bounds.minY
    let halfWidth = waveWidth / 2.0
    let halfHeight = bounds.height / 2.0
    let quarterWidth = waveWidth / 4.0
    
    var up = waveUp
    var startX = bounds.minX - quarterWidth - (waveOffset.truncatingRemainder(dividingBy: waveWidth))
    var endX = startX + halfWidth
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: startX, y: originY))
    path.addLine(to: CGPoint(x: startX, y: bounds.midY))
    
    repeat {
      path.addQuadCurve(
        to: CGPoint(x: endX, y: bounds.midY),
        controlPoint: CGPoint(
          x: startX + quarterWidth,
          y: up ? bounds.maxY + halfHeight : bounds.minY - halfHeight)
      )
      startX = endX
      endX += halfWidth
      up = !up
    } while startX < bounds.maxX
    
    path.addLine(to: CGPoint(x: path.currentPoint.x, y: originY))
    return path
  }
  
  
  // MARK: - Private helper
  
  private func drawPath(_ path: UIBezierPath) {
    layer.mask?.removeFromSuperlayer()
    
    let maskLayer = CAShapeLayer()
    maskLayer.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
    maskLayer.path = path.cgPath
    layer.mask = maskLayer
  }
  
  private func degree2radian(_ degree: CGFloat) -> CGFloat {
    let radian = .pi * degree / 180
    return radian
  }
  
  private func pointFrom(_ angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
    return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
  }
  
  private func retrieveMaskParameters(_ mask: String, maskName: String) -> String {
    var params = mask.replacingOccurrences(of: " ", with: "")
    params = params.replacingOccurrences(of: maskName, with: "")
    params = params.replacingOccurrences(of: "(", with: "")
    params = params.replacingOccurrences(of: ")", with: "")
    return params
  }
  
}
