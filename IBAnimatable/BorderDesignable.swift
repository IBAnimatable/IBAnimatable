//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol BorderDesignable: class {
  /**
   `bordertype: solid, dash, if not specified, solid will be used
   */
  var borderType: BorderType { get set }

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
  var borderSides: BorderSides { get set }

}

public extension BorderDesignable where Self: UITextField {
  public func configureBorder() {
    if borderWidth > 0 {
      borderStyle = .none
    }
    commonConfigBorder()
  }
}

public extension BorderDesignable where Self: UIView {
  public func configureBorder() {
    commonConfigBorder()
  }
}

// MARK: - Layer

fileprivate extension BorderDesignable where Self: UIView {
  func commonConfigBorder() {
    guard borderColor != nil, borderWidth > 0 else {
      clearLayer()
      return
    }

    clearLayer()
    if let mask = layer.mask as? CAShapeLayer {
      applyBorderOnMask(mask)
    } else {
      drawBorders()
    }
  }

  private func clearLayer() {
    layer.borderColor = nil
    layer.borderWidth = 0
    layer.sublayers?.filter { $0.name == "borderSideLayer" || $0.name == "borderAllSides" }
      .forEach { $0.removeFromSuperlayer() }
  }

  private func applyBorderOnMask(_ mask: CAShapeLayer) {
    let borderLayer = CAShapeLayer()
    borderLayer.name = "borderAllSides"
    borderLayer.path = mask.path
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.strokeColor = borderColor!.cgColor
    borderLayer.lineWidth = borderWidth
    borderLayer.frame = bounds
    layer.insertSublayer(borderLayer, at: 0)
  }
}

// MARK: - Drawing

fileprivate extension BorderDesignable where Self: UIView {
  func drawBorders() {
    if borderType == .solid, borderSides == .AllSides {
      layer.borderColor = borderColor!.cgColor
      layer.borderWidth = borderWidth
    } else {
      drawBordersSides()
    }
  }

  func drawBordersSides() {
    let shapeLayer = CAShapeLayer()
    shapeLayer.name = "borderSideLayer"
    shapeLayer.path = makeBorderPath().cgPath
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = borderColor!.cgColor
    shapeLayer.lineWidth = borderWidth
    shapeLayer.frame = bounds
    switch borderType {
    case let .dash(dashLength, spaceLength):
      shapeLayer.lineJoin = kCALineJoinRound
      shapeLayer.lineDashPattern = [dashLength as NSNumber, spaceLength as NSNumber]
    case .solid, .none:
      break
    }
    layer.insertSublayer(shapeLayer, at: 0)
  }

  func makeBorderPath() -> UIBezierPath {
    let lines = makeLines()
    let borderPath = UIBezierPath()
    lines.forEach {
      borderPath.move(to: $0.start)
      borderPath.addLine(to: $0.end)
    }
    return borderPath
  }

  func makeLines() -> [(start: CGPoint, end: CGPoint)] {
    let shift = borderWidth / 2
    var lines = [(start: CGPoint, end: CGPoint)]()
    if borderSides.contains(.top) {
      lines.append((start: CGPoint(x: 0, y: shift), end: CGPoint(x: bounds.size.width, y: shift)))
    }
    if borderSides.contains(.right) {
      lines.append((start: CGPoint(x: bounds.size.width - shift, y: 0), end: CGPoint(x: bounds.size.width - shift, y: bounds.size.height)))
    }
    if borderSides.contains(.bottom) {
      lines.append((start: CGPoint(x: 0, y: bounds.size.height - shift), end: CGPoint(x: bounds.size.width, y: bounds.size.height - shift)))
    }
    if borderSides.contains(.left) {
      lines.append((start: CGPoint(x: shift, y: 0), end: CGPoint(x: shift, y: bounds.size.height)))
    }
    return lines
  }
}
