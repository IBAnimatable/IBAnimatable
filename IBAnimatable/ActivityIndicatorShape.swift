//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

enum ActivityIndicatorShape {
  case circle
  case circleSemi
  case ring
  case ringTwoHalfVertical
  case ringTwoHalfHorizontal
  case ringThirdFour
  case rectangle
  case triangle
  case line
  case pacman

  func makeLayer(size: CGSize, color: UIColor) -> CALayer {
    let lineWidth: CGFloat = 2
    switch self {
    case .circle:
      return makeCircleShapeLayer(with: size, color: color)
    case .circleSemi:
      return makeSemiCircleShapeLayer(with: size, color: color)
    case .ring:
      return makeRingShapeLayer(with: size, color: color, lineWidth: lineWidth)
    case .ringTwoHalfVertical:
      return makeRingTwoHalfVerticalShapeLayer(with: size, color: color, lineWidth: lineWidth)
    case .ringTwoHalfHorizontal:
      return makeRingTwoHalfHorizontalShapeLayer(with: size, color: color, lineWidth: lineWidth)
    case .ringThirdFour:
      return makeRingThirdFourShapeLayer(with: size, color: color, lineWidth: lineWidth)
    case .rectangle:
      return makeRectangleShapeLayer(with: size, color: color)
    case .triangle:
      return makeTriangleShapeLayer(with: size, color: color)
    case .line:
      return makeLineShapeLayer(with: size, color: color)
    case .pacman:
      return makePacmanShapeLayer(with: size, color: color)
    }
  }
}

// MARK: - Circles

private extension ActivityIndicatorShape {

  func makeCircleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                          radius: size.width / 2,
                          startAngle: 0,
                          endAngle: 2 * CGFloat(Double.pi),
                          clockwise: false)
    layer.fillColor = color.cgColor
    layer.apply(path: path, size: size)
    return layer
  }

  func makeSemiCircleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                          radius: size.width / 2,
                          startAngle: -CGFloat(Double.pi) / 6,
                          endAngle: -5 * CGFloat(Double.pi) / 6,
                          clockwise: false)
    path.close()
    layer.fillColor = color.cgColor
    layer.apply(path: path, size: size)
    return layer
  }

}

// MARK: - Rings

private extension ActivityIndicatorShape {

  func makeRingShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                          radius: size.width / 2,
                          startAngle: 0,
                          endAngle: 2 * CGFloat(Double.pi),
                          clockwise: false)
    layer.fillColor = nil
    layer.strokeColor = color.cgColor
    layer.lineWidth = lineWidth
    layer.apply(path: path, size: size)
    return layer
  }

  func makeRingTwoHalfVerticalShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                          radius:size.width / 2,
                          startAngle:-3 * CGFloat(Double.pi) / 4,
                          endAngle:-CGFloat(Double.pi) / 4,
                          clockwise:true)
    path.move(
      to: CGPoint(x: size.width / 2 - size.width / 2 * cos(CGFloat(Double.pi) / 4),
        y: size.height / 2 + size.height / 2 * sin(CGFloat(Double.pi) / 4))
    )
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                          radius:size.width / 2,
                          startAngle:-5 * CGFloat(Double.pi) / 4,
                          endAngle:-7 * CGFloat(Double.pi) / 4,
                          clockwise:false)
    layer.fillColor = nil
    layer.strokeColor = color.cgColor
    layer.lineWidth = lineWidth
    layer.apply(path: path, size: size)
    return layer
  }

  func makeRingTwoHalfHorizontalShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                          radius:size.width / 2,
                          startAngle:3 * CGFloat(Double.pi) / 4,
                          endAngle:5 * CGFloat(Double.pi) / 4,
                          clockwise:true)
    path.move(
      to: CGPoint(x: size.width / 2 + size.width / 2 * cos(CGFloat(Double.pi) / 4),
        y: size.height / 2 - size.height / 2 * sin(CGFloat(Double.pi) / 4))
    )
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                          radius:size.width / 2,
                          startAngle:-CGFloat(Double.pi) / 4,
                          endAngle:CGFloat(Double.pi) / 4,
                          clockwise:true)
    layer.fillColor = nil
    layer.strokeColor = color.cgColor
    layer.lineWidth = lineWidth
    layer.apply(path: path, size: size)
    return layer
  }

  func makeRingThirdFourShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                          radius: size.width / 2,
                          startAngle: -3 * CGFloat(Double.pi) / 4,
                          endAngle: -CGFloat(Double.pi) / 4,
                          clockwise: false)
    layer.fillColor = nil
    layer.strokeColor = color.cgColor
    layer.lineWidth = lineWidth
    layer.apply(path: path, size: size)
    return layer
  }

}

// MARK: - Others

private extension ActivityIndicatorShape {

  func makeRectangleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: size.width, y: 0))
    path.addLine(to: CGPoint(x: size.width, y: size.height))
    path.addLine(to: CGPoint(x: 0, y: size.height))
    layer.fillColor = color.cgColor
    layer.apply(path: path, size: size)
    return layer
  }

  func makeTriangleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    let offsetY = size.height / 4
    path.move(to: CGPoint(x: 0, y: size.height - offsetY))
    path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2 - offsetY))
    path.addLine(to: CGPoint(x: size.width, y: size.height - offsetY))
    path.close()
    layer.fillColor = color.cgColor
    layer.apply(path: path, size: size)
    return layer
  }

  func makeLineShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    var path = UIBezierPath()
    path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height),
                        cornerRadius: size.width / 2)
    layer.fillColor = color.cgColor
    layer.apply(path: path, size: size)
    return layer
  }

  func makePacmanShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let layer = CAShapeLayer()
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                          radius: size.width / 4,
                          startAngle: 0,
                          endAngle: 2 * CGFloat(Double.pi),
                          clockwise: true)
    layer.fillColor = nil
    layer.strokeColor = color.cgColor
    layer.lineWidth = size.width / 2
    layer.apply(path: path, size: size)
    return layer
  }

}

private extension CAShapeLayer {
  func apply(path: UIBezierPath, size: CGSize) {
    self.backgroundColor = nil
    self.path = path.cgPath
    self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
  }
}
