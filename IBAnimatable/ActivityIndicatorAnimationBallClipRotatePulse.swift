//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallClipRotatePulse: ActivityIndicatorAnimating {

  // MARK: Properties

  private let duration: CFTimeInterval = 1
  private let timingFunction = CAMediaTimingFunction(controlPoints: 0.09, 0.57, 0.49, 0.9)

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    smallCircleWith(duration: duration, timingFunction: timingFunction, layer: layer, size: size, color: color)
    bigCircleWith(duration: duration, timingFunction: timingFunction, layer: layer, size: size, color: color)
  }

}

// MARK: Small circle

private extension ActivityIndicatorAnimationBallClipRotatePulse {

  func smallCircleWith(duration duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, layer: CALayer, size: CGSize, color: UIColor) {
    let animation = createSmallCircleAanimation()
    let circleSize = size.width / 2
    let circle = ActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - circleSize) / 2,
                       y: (layer.bounds.size.height - circleSize) / 2,
                       width: circleSize,
                       height: circleSize)
    circle.frame = frame
    circle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

  func createSmallCircleAanimation() -> CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath:"transform.scale")
    animation.keyTimes = [0, 0.3, 1]
    animation.timingFunctions = [timingFunction, timingFunction]
    animation.values = [1, 0.3, 1]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false
    return animation
  }

}

// MARK: Big circle

private extension ActivityIndicatorAnimationBallClipRotatePulse {

  func bigCircleWith(duration duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, layer: CALayer, size: CGSize, color: UIColor) {
    let animation = createBigCircleAanimation()
    let circle = ActivityIndicatorShape.RingTwoHalfVertical.createLayerWith(size: size, color: color)
    let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                       y: (layer.bounds.size.height - size.height) / 2,
                       width: size.width,
                       height: size.height)
    circle.frame = frame
    circle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

  func createBigCircleAanimation() -> CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, rotateAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false
    return animation
  }

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath:"transform.scale")
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.timingFunctions = [timingFunction, timingFunction]
    scaleAnimation.values = [1, 0.6, 1]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var rotateAnimation: CAKeyframeAnimation {
    let rotateAnimation = CAKeyframeAnimation(keyPath:"transform.rotation.z")
    rotateAnimation.keyTimes = scaleAnimation.keyTimes
    rotateAnimation.timingFunctions = [timingFunction, timingFunction]
    rotateAnimation.values = [0, M_PI, 2 * M_PI]
    rotateAnimation.duration = duration
    return rotateAnimation
  }

}
