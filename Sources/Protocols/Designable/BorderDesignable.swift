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

// MARK: - UIView

public extension BorderDesignable where Self: UIView {
  public func configureBorder() {
    configureBorder(in: self)
  }
}

// MARK: - UITextField

public extension BorderDesignable where Self: UITextField {
  public func configureBorder() {
    if borderWidth > 0 {
      borderStyle = .none
    }
    configureBorder(in: self)
  }
}

// MARK: - Common

extension BorderDesignable {
  func configureBorder(in view: UIView) {
    guard borderColor != nil, borderWidth > 0 else {
      clearLayer(in: view)
      return
    }

    clearLayer(in: view)
    if let mask = view.layer.mask as? CAShapeLayer {
      applyBorderOnMask(mask, in: view)
    } else {
      drawBorders(in: view)
    }
  }
}

// MARK: - Layer

extension BorderDesignable {
  private func clearLayer(in view: UIView) {
    view.layer.borderColor = nil
    view.layer.borderWidth = 0
    view.layer.sublayers?.filter { $0.name == "borderSideLayer" || $0.name == "borderAllSides" }
      .forEach { $0.removeFromSuperlayer() }
  }

  private func applyBorderOnMask(_ mask: CAShapeLayer, in view: UIView) {
    let borderLayer = CAShapeLayer()
    borderLayer.name = "borderAllSides"
    borderLayer.path = mask.path
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.strokeColor = borderColor!.cgColor
    borderLayer.lineWidth = borderWidth
    borderLayer.frame = view.bounds
    view.layer.insertSublayer(borderLayer, at: 0)
  }
}

// MARK: - Drawing

extension BorderDesignable {
  private func drawBorders(in view: UIView) {
    if borderType == .solid, borderSides == .AllSides {
      view.layer.borderColor = borderColor!.cgColor
      view.layer.borderWidth = borderWidth
    } else {
      drawBordersSides(in: view)
    }
  }

  private func drawBordersSides(in view: UIView) {
    let shapeLayer = CAShapeLayer()
    shapeLayer.name = "borderSideLayer"
    shapeLayer.path = makeBorderPath(in: view.bounds).cgPath
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = borderColor!.cgColor
    shapeLayer.lineWidth = borderWidth
    shapeLayer.frame = view.bounds
    switch borderType {
    case let .dash(dashLength, spaceLength):
      shapeLayer.lineJoin = CAShapeLayerLineJoin.round
      shapeLayer.lineDashPattern = [dashLength as NSNumber, spaceLength as NSNumber]
    case .solid, .none:
      break
    }
    view.layer.insertSublayer(shapeLayer, at: 0)
  }

  private func makeBorderPath(in bounds: CGRect) -> UIBezierPath {
    let lines = makeLines(in: bounds)
    let borderPath = UIBezierPath()
    lines.forEach {
      borderPath.move(to: $0.start)
      borderPath.addLine(to: $0.end)
    }
    return borderPath
  }

  private func makeLines(in bounds: CGRect) -> [(start: CGPoint, end: CGPoint)] {
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
