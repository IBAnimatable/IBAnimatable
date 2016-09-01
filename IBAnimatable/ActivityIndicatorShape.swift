//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

enum ActivityIndicatorShape {
  case Circle
  case CircleSemi
  case Ring
  case RingTwoHalfVertical
  case RingTwoHalfHorizontal
  case RingThirdFour
  case Rectangle
  case Triangle
  case Line
  case Pacman

  func createLayerWith(size size: CGSize, color: UIColor) -> CALayer {
    let lineWidth: CGFloat = 2    
    switch self {
    case .Circle:
      return circleShapeLayer(with: size, color: color)
    case .CircleSemi:
      return semiCircleShapeLayer(with: size, color: color)
    case .Ring:
      return ringShapeLayer(with: size, color: color, lineWidth: lineWidth)
    case .RingTwoHalfVertical:
      return ringTwoHalfVerticalShapeLayer(with: size, color: color, lineWidth: lineWidth)
    case .RingTwoHalfHorizontal:
      return ringTwoHalfHorizontalShapeLayer(with: size, color: color, lineWidth: lineWidth)
    case .RingThirdFour:
      return ringThirdFourShapeLayer(with: size, color: color, lineWidth: lineWidth)
    case .Rectangle:
      return rectangleShapeLayer(with: size, color: color)
    case .Triangle:
      return triangleShapeLayer(with: size, color: color)
    case .Line:
      return lineShapeLayer(with: size, color: color)
    case .Pacman:
      return pacmanShapeLayer(with: size, color: color)
    }
  }

  func completingLayer(layer: CAShapeLayer, path: UIBezierPath, size: CGSize) -> CAShapeLayer {
    layer.backgroundColor = nil
    layer.path = path.CGPath
    layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    return layer
  }

}

// MARK: - Circles

private extension ActivityIndicatorShape {

  func circleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArcWithCenter(CGPoint(x: size.width / 2, y: size.height / 2),
                          radius: size.width / 2,
                          startAngle: 0,
                          endAngle: CGFloat(2 * M_PI),
                          clockwise: false)
    layer.fillColor = color.CGColor
    return completingLayer(layer, path: path, size: size)
  }

  func semiCircleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArcWithCenter(CGPoint(x: size.width / 2, y: size.height / 2),
                          radius: size.width / 2,
                          startAngle: CGFloat(-M_PI / 6),
                          endAngle: CGFloat(-5 * M_PI / 6),
                          clockwise: false)
    path.closePath()
    layer.fillColor = color.CGColor
    return completingLayer(layer, path: path, size: size)
  }

}

// MARK: - Rings

private extension ActivityIndicatorShape {

  func ringShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArcWithCenter(CGPoint(x: size.width / 2, y: size.height / 2),
                          radius: size.width / 2,
                          startAngle: 0,
                          endAngle: CGFloat(2 * M_PI),
                          clockwise: false)
    layer.fillColor = nil
    layer.strokeColor = color.CGColor
    layer.lineWidth = lineWidth
    return completingLayer(layer, path: path, size: size)
  }

  func ringTwoHalfVerticalShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArcWithCenter(CGPoint(x: size.width / 2, y: size.height / 2),
                          radius:size.width / 2,
                          startAngle:CGFloat(-3 * M_PI_4),
                          endAngle:CGFloat(-M_PI_4),
                          clockwise:true)
    path.moveToPoint(
      CGPoint(x: size.width / 2 - size.width / 2 * CGFloat(cos(M_PI_4)),
        y: size.height / 2 + size.height / 2 * CGFloat(sin(M_PI_4)))
    )
    path.addArcWithCenter(CGPoint(x: size.width / 2, y: size.height / 2),
                          radius:size.width / 2,
                          startAngle:CGFloat(-5 * M_PI_4),
                          endAngle:CGFloat(-7 * M_PI_4),
                          clockwise:false)
    layer.fillColor = nil
    layer.strokeColor = color.CGColor
    layer.lineWidth = lineWidth
    return completingLayer(layer, path: path, size: size)
  }

  func ringTwoHalfHorizontalShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArcWithCenter(CGPoint(x: size.width / 2, y: size.height / 2),
                          radius:size.width / 2,
                          startAngle:CGFloat(3 * M_PI_4),
                          endAngle:CGFloat(5 * M_PI_4),
                          clockwise:true)
    path.moveToPoint(
      CGPoint(x: size.width / 2 + size.width / 2 * CGFloat(cos(M_PI_4)),
        y: size.height / 2 - size.height / 2 * CGFloat(sin(M_PI_4)))
    )
    path.addArcWithCenter(CGPoint(x: size.width / 2, y: size.height / 2),
                          radius:size.width / 2,
                          startAngle:CGFloat(-M_PI_4),
                          endAngle:CGFloat(M_PI_4),
                          clockwise:true)
    layer.fillColor = nil
    layer.strokeColor = color.CGColor
    layer.lineWidth = lineWidth
    return completingLayer(layer, path: path, size: size)
  }

  func ringThirdFourShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArcWithCenter(CGPoint(x: size.width / 2, y: size.height / 2),
                          radius: size.width / 2,
                          startAngle: CGFloat(-3 * M_PI_4),
                          endAngle: CGFloat(-M_PI_4),
                          clockwise: false)
    layer.fillColor = nil
    layer.strokeColor = color.CGColor
    layer.lineWidth = lineWidth
    return completingLayer(layer, path: path, size: size)
  }

}

// MARK: - Others

private extension ActivityIndicatorShape {

  func rectangleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.moveToPoint(CGPoint(x: 0, y: 0))
    path.addLineToPoint(CGPoint(x: size.width, y: 0))
    path.addLineToPoint(CGPoint(x: size.width, y: size.height))
    path.addLineToPoint(CGPoint(x: 0, y: size.height))
    layer.fillColor = color.CGColor
    return completingLayer(layer, path: path, size: size)
  }

  func triangleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    let offsetY = size.height / 4
    path.moveToPoint(CGPoint(x: 0, y: size.height - offsetY))
    path.addLineToPoint(CGPoint(x: size.width / 2, y: size.height / 2 - offsetY))
    path.addLineToPoint(CGPoint(x: size.width, y: size.height - offsetY))
    path.closePath()
    layer.fillColor = color.CGColor
    return completingLayer(layer, path: path, size: size)
  }

  func lineShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    var path = UIBezierPath()
    path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height),
                        cornerRadius: size.width / 2)
    layer.fillColor = color.CGColor
    return completingLayer(layer, path: path, size: size)
  }

  func pacmanShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArcWithCenter(CGPoint(x: size.width / 2, y: size.height / 2),
                          radius: size.width / 4,
                          startAngle: 0,
                          endAngle: CGFloat(2 * M_PI),
                          clockwise: true)
    layer.fillColor = nil
    layer.strokeColor = color.CGColor
    layer.lineWidth = size.width / 2
    return completingLayer(layer, path: path, size: size)
  }

}
