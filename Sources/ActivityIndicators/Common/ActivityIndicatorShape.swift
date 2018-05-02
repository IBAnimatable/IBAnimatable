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
  case offsetTriangle
  case line
  case pacman
  case stroke
  case mask(type: MaskType)

  func makeLayer(size: CGSize, color: UIColor, lineWidth: CGFloat = 2) -> CALayer {
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
    case .offsetTriangle:
      return makeOffsetTriangleShapeLayer(with: size, color: color)
    case .line:
      return makeLineShapeLayer(with: size, color: color)
    case .pacman:
      return makePacmanShapeLayer(with: size, color: color)
    case .stroke:
      return makeStrokeSphapeLayer(with: size, color: color)
    case .mask(let type):
      return makeMaskShapeLayer(with: size, color: color, type: type)
    }
  }
}

private extension ActivityIndicatorShape {

  enum DrawingMode {
    case fill
    case stroke(lineWidth: CGFloat)
    case fillStroke(lineWidth: CGFloat)
  }

  func makeStrokeSphapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -(.pi / 2),
                endAngle: .pi + .pi / 2,
                clockwise: true)

    return makeShapeLayer(with: size, color: color, path: path, mode: .stroke(lineWidth: 2))
  }

  func makeShapeLayer(with size: CGSize, color: UIColor, path: UIBezierPath, mode: DrawingMode) -> CAShapeLayer {
    let layer = CAShapeLayer()
    switch mode {
    case .fill:
      layer.fillColor = color.cgColor
    case .stroke(let lineWidth):
      layer.strokeColor = color.cgColor
      layer.lineWidth = lineWidth
      layer.fillColor = nil
    case .fillStroke(let lineWidth):
      layer.strokeColor = color.cgColor
      layer.lineWidth = lineWidth
      layer.fillColor = color.cgColor
    }
    layer.apply(path: path, size: size)
    return layer
  }

  func makeMaskShapeLayer(with size: CGSize, color: UIColor, type: MaskType) -> CAShapeLayer {
    let path = type.bezierPath(in: CGRect(origin: .zero, size: size))
    return makeShapeLayer(with: size, color: color, path: path, mode: .fill)
  }

}

// MARK: - Circles

private extension ActivityIndicatorShape {

  func makeCircleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: 0,
                endAngle: 2 * CGFloat(Double.pi),
                clockwise: false)
    return makeShapeLayer(with: size, color: color, path: path, mode: .fill)
  }

  func makeSemiCircleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -CGFloat(Double.pi) / 6,
                endAngle: -5 * CGFloat(Double.pi) / 6,
                clockwise: false)
    path.close()
    return makeShapeLayer(with: size, color: color, path: path, mode: .fill)
  }

}

// MARK: - Rings

private extension ActivityIndicatorShape {

  func makeRingShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: 0,
                endAngle: 2 * CGFloat(Double.pi),
                clockwise: false)
    return makeShapeLayer(with: size, color: color, path: path, mode: .stroke(lineWidth: lineWidth))
  }

  func makeRingTwoHalfVerticalShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {()
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -3 * CGFloat(Double.pi) / 4,
                endAngle: -CGFloat(Double.pi) / 4,
                clockwise: true)
    path.move(
      to: CGPoint(x: size.width / 2 - size.width / 2 * cos(CGFloat(Double.pi) / 4),
                  y: size.height / 2 + size.height / 2 * sin(CGFloat(Double.pi) / 4))
    )
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -5 * CGFloat(Double.pi) / 4,
                endAngle: -7 * CGFloat(Double.pi) / 4,
                clockwise: false)
    return makeShapeLayer(with: size, color: color, path: path, mode: .stroke(lineWidth: lineWidth))
  }

  func makeRingTwoHalfHorizontalShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: 3 * CGFloat(Double.pi) / 4,
                endAngle: 5 * CGFloat(Double.pi) / 4,
                clockwise: true)
    path.move(
      to: CGPoint(x: size.width / 2 + size.width / 2 * cos(CGFloat(Double.pi) / 4),
                  y: size.height / 2 - size.height / 2 * sin(CGFloat(Double.pi) / 4))
    )
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -CGFloat(Double.pi) / 4,
                endAngle: CGFloat(Double.pi) / 4,
                clockwise: true)
    return makeShapeLayer(with: size, color: color, path: path, mode: .stroke(lineWidth: lineWidth))
  }

  func makeRingThirdFourShapeLayer(with size: CGSize, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 2,
                startAngle: -3 * CGFloat(Double.pi) / 4,
                endAngle: -CGFloat(Double.pi) / 4,
                clockwise: false)
    return makeShapeLayer(with: size, color: color, path: path, mode: .stroke(lineWidth: lineWidth))
  }

}

// MARK: - Others

private extension ActivityIndicatorShape {

  func makeRectangleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let path = UIBezierPath()
    path.move(to: .zero)
    path.addLine(to: CGPoint(x: size.width, y: 0))
    path.addLine(to: CGPoint(x: size.width, y: size.height))
    path.addLine(to: CGPoint(x: 0, y: size.height))
    return makeShapeLayer(with: size, color: color, path: path, mode: .fill)
  }

  func makeOffsetTriangleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let path = UIBezierPath()
    let offsetY = size.height / 4
    path.move(to: CGPoint(x: 0, y: size.height - offsetY))
    path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2 - offsetY))
    path.addLine(to: CGPoint(x: size.width, y: size.height - offsetY))
    path.close()
    return makeShapeLayer(with: size, color: color, path: path, mode: .fill)
  }

  func makeTriangleShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: size.height))
    path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2))
    path.addLine(to: CGPoint(x: size.width, y: size.height))
    path.close()
    return makeShapeLayer(with: size, color: color, path: path, mode: .fill)
  }

  func makeLineShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                y: 0,
                                                width: size.width,
                                                height: size.height),
                            cornerRadius: size.width / 2)
    return makeShapeLayer(with: size, color: color, path: path, mode: .fill)
  }

  func makePacmanShapeLayer(with size: CGSize, color: UIColor) -> CAShapeLayer {
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                radius: size.width / 4,
                startAngle: 0,
                endAngle: 2 * CGFloat(Double.pi),
                clockwise: true)
    return makeShapeLayer(with: size, color: color, path: path, mode: .stroke(lineWidth: size.width / 2))
  }

}

private extension CAShapeLayer {
  func apply(path: UIBezierPath, size: CGSize) {
    self.backgroundColor = nil
    self.path = path.cgPath
    self.frame = CGRect(origin: .zero, size: size)
  }
}
