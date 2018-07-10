//  Created by phimage on 07/05/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

@IBDesignable
final class TimingFunctionView: UIView {

  // some sub layers
  private var shapeLayer: CAShapeLayer!
  private var tangentsLayer: CAShapeLayer!

  @IBInspectable var _timingFunction: String = "" {
    didSet {
      timingFunction = TimingFunctionType(string: _timingFunction)
    }
  }
  public var timingFunction: TimingFunctionType = .none {
    didSet {
      self.setNeedsLayout()
    }
  }

  @IBInspectable var strokeColor: UIColor = .black {
    didSet {
      self.shapeLayer.strokeColor = strokeColor.cgColor
      self.tangentsLayer.strokeColor = strokeColor.cgColor
    }
  }

  @IBInspectable var displayNone: Bool = true {
    didSet {
      self.setNeedsLayout()
    }
  }

  // MARK: init
  override init(frame: CGRect) {
    super.init(frame: frame)
    initSubLayers()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initSubLayers()
  }

  private func initSubLayers() {
    shapeLayer = CAShapeLayer()
    shapeLayer.strokeColor = self.strokeColor.cgColor
    shapeLayer.fillColor = nil
    shapeLayer.anchorPoint = .zero
    self.layer.addSublayer(shapeLayer)

    tangentsLayer = CAShapeLayer()
    tangentsLayer.strokeColor = self.strokeColor.cgColor
    tangentsLayer.fillColor = nil
    tangentsLayer.anchorPoint = .zero
    tangentsLayer.lineDashPattern = [5, 2]
    self.layer.addSublayer(tangentsLayer)
  }

  // MARK: override
  override func layoutSubviews() {
    super.layoutSubviews()

    let ownBounds = self.bounds
    self.shapeLayer.bounds = ownBounds

    if case .none = self.timingFunction, !displayNone {
      self.shapeLayer.path = nil
      self.tangentsLayer.path = nil
    } else {
      let width = ownBounds.size.width
      let height = ownBounds.size.height
      // The control points defining the Bézier curve are [(0.0,0.0), (c1.x,c1.y), (c2.x,c2.y), (1.0,1.0)]
      var controlPoints: [CGPoint] = []
      for i in 0..<4 {
        let array = UnsafeMutablePointer<Float>.allocate(capacity: 2)
        timingFunction.caType.getControlPoint(at: i, values: array)

        let controlPoint = CGPoint(x: CGFloat(array[0]), y: CGFloat(1.0 - array[1]))
        let point = CGPoint(x: controlPoint.x * width, y: controlPoint.y * height)
        array.deallocate()

        controlPoints.append(point)
      }

      let curve = UIBezierPath()
      curve.move(to: controlPoints[0])
      curve.addCurve(to: controlPoints[3], controlPoint1: controlPoints[1], controlPoint2: controlPoints[2])
      self.shapeLayer.path = curve.cgPath

      let tangents = UIBezierPath()
      tangents.move(to: controlPoints[0])
      tangents.addLine(to: controlPoints[1])
      tangents.move(to: controlPoints[3])
      tangents.addLine(to: controlPoints[2])
      self.tangentsLayer.path = tangents.cgPath
    }
  }

}
