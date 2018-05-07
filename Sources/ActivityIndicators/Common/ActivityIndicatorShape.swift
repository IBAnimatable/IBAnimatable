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
}

extension ActivityIndicatorShape {

  func makeLayer(size: CGSize, color: UIColor) -> CALayer {
    let path = self.path(size: size)
    let drawingMode = self.drawingMode(size: size)
    return ActivityIndicatorShape.makeShapeLayer(with: size,
                                                 color: color,
                                                 path: path,
                                                 mode: drawingMode)
  }

  func path(size: CGSize) -> UIBezierPath {
    switch self {
    case .circle:
      return makeCirclePath(with: size)
    case .circleSemi:
      return makeSemiCirclePath(with: size)
    case .ring:
      return makeRingPath(with: size)
    case .ringTwoHalfVertical:
      return makeRingTwoHalfVerticalPath(with: size)
    case .ringTwoHalfHorizontal:
      return makeRingTwoHalfHorizontalPath(with: size)
    case .ringThirdFour:
      return makeRingThirdFourPath(with: size)
    case .rectangle:
      return makeRectanglePath(with: size)
    case .triangle:
      return makeTrianglePath(with: size)
    case .offsetTriangle:
      return makeOffsetTrianglePath(with: size)
    case .line:
      return makeLinePath(with: size)
    case .pacman:
      return makePacmanPath(with: size)
    case .stroke:
      return makeStrokePath(with: size)
    case .mask(let type):
      return makeMaskPath(with: size, type: type)
    }
  }

  fileprivate func drawingMode(size: CGSize) -> CAShapeLayer.DrawingMode {
    switch self {
    case .ring, .ringTwoHalfVertical, .ringTwoHalfHorizontal, .ringThirdFour, .stroke:
      return .stroke(lineWidth: 2)
    case .pacman:
      return .stroke(lineWidth: size.width / 2)
    default:
      return .fill
    }
  }

}

private extension ActivityIndicatorShape {

  static func makeShapeLayer(with size: CGSize, color: UIColor, path: UIBezierPath, mode: CAShapeLayer.DrawingMode) -> CAShapeLayer {
    let layer = CAShapeLayer()
    layer.apply(mode: mode, color: color)
    layer.backgroundColor = nil
    layer.path = path.cgPath
    layer.frame = size.rect
    return layer
  }

}

// MARK: - Circles

private extension ActivityIndicatorShape {

  func makeCirclePath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath()
    path.addArc(withCenter: size.center,
                radius: size.width / 2,
                startAngle: 0,
                endAngle: 2 * CGFloat.pi,
                clockwise: false)
    return path
  }

  func makeSemiCirclePath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath()
    path.addArc(withCenter: size.center,
                radius: size.width / 2,
                startAngle: -CGFloat.pi / 6,
                endAngle: -5 * CGFloat.pi / 6,
                clockwise: false)
    path.close()
    return path
  }

}

// MARK: - Rings

private extension ActivityIndicatorShape {

  func makeRingPath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath()
    path.addArc(withCenter: size.center,
                radius: size.width / 2,
                startAngle: 0,
                endAngle: 2 * CGFloat.pi,
                clockwise: false)
    return path
  }

  func makeRingTwoHalfVerticalPath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath()
    path.addArc(withCenter: size.center,
                radius: size.width / 2,
                startAngle: -3 * CGFloat.pi / 4,
                endAngle: -CGFloat.pi / 4,
                clockwise: true)
    path.move(
      to: CGPoint(x: size.width / 2 - size.width / 2 * cos(.pi / 4),
                  y: size.height / 2 + size.height / 2 * sin(.pi / 4))
    )
    path.addArc(withCenter: size.center,
                radius: size.width / 2,
                startAngle: -5 * .pi / 4,
                endAngle: -7 * .pi / 4,
                clockwise: false)
    return path
  }

  func makeRingTwoHalfHorizontalPath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath()
    path.addArc(withCenter: size.center,
                radius: size.width / 2,
                startAngle: 3 * .pi / 4,
                endAngle: 5 * .pi / 4,
                clockwise: true)
    path.move(
      to: CGPoint(x: size.width / 2 + size.width / 2 * cos(.pi / 4),
                  y: size.height / 2 - size.height / 2 * sin(.pi / 4))
    )
    path.addArc(withCenter: size.center,
                radius: size.width / 2,
                startAngle: -.pi / 4,
                endAngle: .pi / 4,
                clockwise: true)
    return path
  }

  func makeRingThirdFourPath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath()
    path.addArc(withCenter: size.center,
                radius: size.width / 2,
                startAngle: -3 * .pi / 4,
                endAngle: -.pi / 4,
                clockwise: false)
    return path
  }

}

// MARK: - Others

private extension ActivityIndicatorShape {

  func makeRectanglePath(with size: CGSize) -> UIBezierPath {
    return UIBezierPath(rect: size.rect)
  }

  func makeOffsetTrianglePath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath()
    let offsetY = size.height / 4
    path.move(to: CGPoint(x: 0, y: size.height - offsetY))
    path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2 - offsetY))
    path.addLine(to: CGPoint(x: size.width, y: size.height - offsetY))
    path.close()
    return path
  }

  func makeTrianglePath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: size.bottomLeft)
    path.addLine(to: size.center)
    path.addLine(to: size.bottomRight)
    path.close()
    return path
  }

  func makeLinePath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath(roundedRect: size.rect,
                            cornerRadius: size.width / 2)
    return path
  }

  func makeStrokePath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath()
    path.addArc(withCenter: size.center,
                radius: size.width / 2,
                startAngle: -(.pi / 2),
                endAngle: .pi + .pi / 2,
                clockwise: true)

    return path
  }

  func makePacmanPath(with size: CGSize) -> UIBezierPath {
    let path = UIBezierPath()
    path.addArc(withCenter: size.center,
                radius: size.width / 4,
                startAngle: 0,
                endAngle: 2 * .pi,
                clockwise: true)
    return path
  }

  func makeMaskPath(with size: CGSize, type: MaskType) -> UIBezierPath {
    return type.bezierPath(in: size.rect)
  }

}

// MARK: - CAShapeLayer

extension CAShapeLayer {

  enum DrawingMode {
    case fill
    case stroke(lineWidth: CGFloat)
    case fillStroke(lineWidth: CGFloat)
  }

  func apply(mode: DrawingMode, color: UIColor) {
    switch mode {
    case .fill:
      self.fillColor = color.cgColor
    case .stroke(let lineWidth):
      self.strokeColor = color.cgColor
      self.lineWidth = lineWidth
      self.fillColor = nil
    case .fillStroke(let lineWidth):
      self.strokeColor = color.cgColor
      self.lineWidth = lineWidth
      self.fillColor = color.cgColor
    }
  }

}

private extension CGSize {
  var rect: CGRect {
    return CGRect(origin: .zero, size: self)
  }
  var center: CGPoint {
    return CGPoint(x: self.width / 2, y: self.height / 2)
  }
  var bottomRight: CGPoint {
    return CGPoint(x: self.width, y: self.height)
  }
  var bottomLeft: CGPoint {
    return CGPoint(x: 0, y: self.height)
  }
}
