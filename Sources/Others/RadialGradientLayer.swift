//
//  RadialGradientLayer.swift
//  IBAnimatable
//
//  Created by Tom Baranes on 08/01/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

final class RadialGradientLayer: CALayer {
  var startPoint: CGPoint = .zero
  var endPoint: CGPoint = .zero
  var colors = [CGColor]()

  required override init() {
    super.init()
    needsDisplayOnBoundsChange = true
  }

  required init(coder aDecoder: NSCoder) {
    super.init()
  }

  override func draw(in ctx: CGContext) {
    ctx.saveGState()
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0,1.0])!
    let size = frame.size
    let radius = max(max(size.width - endPoint.x, endPoint.x), max(size.height - endPoint.y, endPoint.y))
    ctx.drawRadialGradient(gradient,
                           startCenter: startPoint,
                           startRadius: 0,
                           endCenter: endPoint,
                           endRadius: radius,
                           options: .drawsAfterEndLocation)
  }

}
