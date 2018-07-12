//
//  ConicalGradientLayer.swift
//  IBAnimatable
//
//  Created by Eric Marchand on 22/03/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

final class ConicalGradientLayer: CALayer {

  required override init() {
    super.init()
    needsDisplayOnBoundsChange = true
  }

  required init(coder aDecoder: NSCoder) {
    super.init()
  }

  public var colors = [CGColor]() {
    didSet {
      setNeedsDisplay()
    }
  }

  /// Start angle in radians. Defaults to 0.
  public var startAngle: Double = 0.0 {
    didSet {
      setNeedsDisplay()
    }
  }

  /// End angle in radians. Defaults to 2 pi.
  public var endAngle: Double = 2 * .pi {
    didSet {
      setNeedsDisplay()
    }
  }

  public let centerPoint: CGPoint = CGPoint(x: 0.5, y: 0.5)

  public var startPoint: CGPoint {
    get {
      assertionFailure("not implemented")
      return .zero
    }
    set {
      let centeredPoint = CGPoint(x: newValue.x - centerPoint.x,
                                  y: newValue.y - centerPoint.y)
      var angle = Double(atan2(centeredPoint.y - self.frame.midY, centeredPoint.x - self.frame.midX))
      if angle < 0 {
        angle += 2 * .pi
      }
      self.startAngle = angle
    }
  }

  public var endPoint: CGPoint {
    get {
      assertionFailure("not implemented")
      return .zero
    }
    set {
      let centeredPoint = CGPoint(x: centerPoint.x - newValue.x,
                                  y: centerPoint.y - newValue.y)
      var angle = Double(atan2(centeredPoint.y - self.frame.midY, centeredPoint.x - self.frame.midX))
      if angle < 0 {
        angle += 2 * .pi
      }
      self.endAngle = angle + 2 * .pi
    }
  }

  /// List of computed color transitions.
  private var transitions = [UIColor.Transition]()

  public override func draw(in ctx: CGContext) {
    UIGraphicsPushContext(ctx)
    draw(in: ctx.boundingBoxOfClipPath)
    UIGraphicsPopContext()
  }

  private func draw(in rect: CGRect) {
    configureTransitions()

    let center = CGPoint(x: rect.width * centerPoint.x,
                         y: rect.height * centerPoint.y)
    let longerSide = max(rect.width, rect.height)
    let radius = Double(longerSide) * 2.squareRoot()
    let step = (.pi / 2) / radius
    var angle = startAngle

    while angle <= endAngle {
      let pointX = radius * cos(angle) + Double(center.x)
      let pointY = radius * sin(angle) + Double(center.y)
      let startPoint = CGPoint(x: pointX, y: pointY)

      let line = UIBezierPath()
      line.move(to: startPoint)
      line.addLine(to: center)
      color(forAngle: angle - startAngle, on: (endAngle - startAngle)).setStroke()
      line.stroke()

      angle += step
    }
  }

  private func color(forAngle angle: Double, on arc: Double) -> UIColor {
    let percent = angle / arc
    guard let transition = transition(forPercent: percent) else {
      return UIColor(hue: CGFloat(percent), saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
    return transition.color(forPercent: percent)
  }

  private func configureTransitions() {
    transitions.removeAll()

    if colors.count > 1 {
      let transitionsCount = colors.count - 1
      let step = 1.0 / Double(transitionsCount)

      for i in 0 ..< transitionsCount {
        let fromLocation = step * Double(i)
        let toLocation = step * Double(i + 1)

        let fromColor = UIColor(cgColor: colors[i])
        let toColor = UIColor(cgColor: colors[i + 1])

        transitions.append(.init(fromLocation: fromLocation,
                                 toLocation: toLocation,
                                 fromColor: fromColor,
                                 toColor: toColor))
      }
    }
  }

  private func transition(forPercent percent: Double) -> UIColor.Transition? {
    let filtered = transitions.filter { percent >= $0.fromLocation && percent < $0.toLocation }
    if let first = filtered.first {
      return first
    }
    return percent <= 0.5 ? transitions.first : transitions.last // only to complete
  }

}

// MARK: UIColor

private extension UIColor {

  struct RGBA {
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 0.0

    init(color: UIColor) {
      color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
  }

  var rgba: RGBA {
    return RGBA(color: self)
  }

  struct Transition {

    let fromLocation: Double
    let toLocation: Double

    let fromColor: UIColor
    let toColor: UIColor

    func color(forPercent percent: Double) -> UIColor {
      let normalizedPercent = percent.normalize(fromMin: fromLocation, max: toLocation)
      return UIColor.lerp(from: fromColor.rgba, to: toColor.rgba, percent: CGFloat(normalizedPercent))
    }

  }

  class func lerp(from: UIColor.RGBA, to: UIColor.RGBA, percent: CGFloat) -> UIColor {
    let red = from.red + percent * (to.red - from.red)
    let green = from.green + percent * (to.green - from.green)
    let blue = from.blue + percent * (to.blue - from.blue)
    let alpha = from.alpha + percent * (to.alpha - from.alpha)
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }

}

// MARK: - Double

private extension Double {

  func normalize(fromMin min: Double, max: Double) -> Double {
    let range = max - min
    if range == 0 {
      return 0
    }
    return (self - min) / range
  }

}
