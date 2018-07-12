//
//  ActivityIndicatorAnimationCircleDashStrokeSpin.swift
//  IBAnimatable
//
//  Created by phimage on 03/05/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationCircleDashStrokeSpin: ActivityIndicatorAnimating {

  // MARK: Properties

  let duration: Double = 1.5
  let rotationDuration: Double = 10
  let lineWidth: CGFloat = 4
  let instanceCount: Int = 12

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2

    let replicatorLayer = CAReplicatorLayer()
    replicatorLayer.frame = CGRect(x: x, y: y, width: size.width, height: size.height)

    let dotLayer = CAShapeLayer()
    dotLayer.lineCap = CAShapeLayerLineCap.round
    dotLayer.apply(mode: .stroke(lineWidth: lineWidth), color: color)

    let angle: CGFloat = 2 * .pi / CGFloat(instanceCount)
    replicatorLayer.instanceCount = instanceCount
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
    replicatorLayer.instanceDelay = 1.5 * duration / Double(instanceCount)

    let maxRadius = max(0, min(replicatorLayer.bounds.width, replicatorLayer.bounds.height)) / 2
    let radius: CGFloat = maxRadius - lineWidth / 2

    dotLayer.bounds = CGRect(x: 0, y: 0, width: 2 * maxRadius, height: 2 * maxRadius)
    dotLayer.position = CGPoint(x: replicatorLayer.bounds.width / 2, y: replicatorLayer.bounds.height / 2)

    let path = UIBezierPath(arcCenter: CGPoint(x: maxRadius, y: maxRadius),
                            radius: radius,
                            startAngle: -angle / 2 - CGFloat.pi / 2,
                            endAngle: angle / 2 - CGFloat.pi / 2,
                            clockwise: true)
    dotLayer.path = path.cgPath

    replicatorLayer.add(rotationAnimation, forKey: "rotate")
    dotLayer.add(strokeStartAnimation, forKey: "start")
    dotLayer.add(strokeEndAnimation, forKey: "end")
    dotLayer.add(lineWidthAnimation, forKey: "lineWidth")

    replicatorLayer.addSublayer(dotLayer)
    layer.addSublayer(replicatorLayer)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationCircleDashStrokeSpin {

  var rotationAnimation: CABasicAnimation {
    let rotationAnimation = CABasicAnimation(keyPath: .rotation)
    rotationAnimation.byValue = Float.pi * 2
    rotationAnimation.timingFunctionType = .linear
    rotationAnimation.duration = rotationDuration
    return rotationAnimation
  }

  var strokeStartAnimation: CABasicAnimation {
    let strokeStartAnimation = CABasicAnimation(keyPath: .strokeStart)
    strokeStartAnimation.duration = duration
    strokeStartAnimation.timingFunctionType = .easeInOut
    strokeStartAnimation.fromValue = 0
    strokeStartAnimation.toValue = 0.5
    strokeStartAnimation.autoreverses = true
    strokeStartAnimation.repeatCount = .infinity
    return strokeStartAnimation
  }

  var strokeEndAnimation: CABasicAnimation {
    let strokeEndAnimation = CABasicAnimation(keyPath: .strokeEnd)
    strokeEndAnimation.duration = duration
    strokeEndAnimation.timingFunctionType = .easeInOut
    strokeEndAnimation.fromValue = 1.0
    strokeEndAnimation.toValue = 0.5
    strokeEndAnimation.autoreverses = true
    strokeEndAnimation.repeatCount = .infinity
    return strokeEndAnimation
  }

  var lineWidthAnimation: CABasicAnimation {
    let lineWidthAnimation = CABasicAnimation(keyPath: .lineWidth)
    lineWidthAnimation.fromValue = lineWidth
    lineWidthAnimation.toValue = 0.0
    lineWidthAnimation.duration = duration
    lineWidthAnimation.autoreverses = true
    lineWidthAnimation.repeatCount = .infinity
    lineWidthAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.55, 0.0, 0.45, 1.0)
    return lineWidthAnimation
  }

}
