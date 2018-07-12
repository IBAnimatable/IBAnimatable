//
//  ActivityIndicatorAnimationCircleStrokeSpin.swift
//  IBAnimatable
//
//  Created by phimage on 02/05/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationCircleStrokeSpin: ActivityIndicatorAnimating {

  // MARK: Properties

  let beginTime: Double = 0.5
  let strokeStartDuration: Double = 1.2
  let strokeEndDuration: Double = 0.7

  let timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let circle = ActivityIndicatorShape.stroke.makeLayer(size: size, color: color)
    circle.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
    circle.add(defaultAnimation, forKey: "animation")
    layer.addSublayer(circle)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationCircleStrokeSpin {

  var defaultAnimation: CAAnimationGroup {
    let groupAnimation = CAAnimationGroup()
    groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
    groupAnimation.duration = strokeStartDuration + beginTime
    groupAnimation.repeatCount = .infinity
    groupAnimation.isRemovedOnCompletion = false
    groupAnimation.fillMode = CAMediaTimingFillMode.forwards
    return groupAnimation
  }

  var rotationAnimation: CABasicAnimation {
    let rotationAnimation = CABasicAnimation(keyPath: .rotation)
    rotationAnimation.byValue = Float.pi * 2
    rotationAnimation.timingFunctionType = .linear
    return rotationAnimation
  }

  var strokeEndAnimation: CABasicAnimation {
    let strokeEndAnimation = CABasicAnimation(keyPath: .strokeEnd)
    strokeEndAnimation.duration = strokeEndDuration
    strokeEndAnimation.timingFunction = timingFunction
    strokeEndAnimation.fromValue = 0
    strokeEndAnimation.toValue = 1
    return strokeEndAnimation
  }

  var strokeStartAnimation: CABasicAnimation {
    let strokeStartAnimation = CABasicAnimation(keyPath: .strokeStart)
    strokeStartAnimation.duration = strokeStartDuration
    strokeStartAnimation.timingFunction = timingFunction
    strokeStartAnimation.fromValue = 0
    strokeStartAnimation.toValue = 1
    strokeStartAnimation.beginTime = beginTime
    return strokeStartAnimation
  }

}
