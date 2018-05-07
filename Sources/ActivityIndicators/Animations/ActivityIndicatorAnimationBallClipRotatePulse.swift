//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallClipRotatePulse: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 1
  fileprivate let timingFunction = CAMediaTimingFunction(controlPoints: 0.09, 0.57, 0.49, 0.9)

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    animateSmallCircle(duration: duration, timingFunction: timingFunction, layer: layer, size: size, color: color)
    animateBigCircle(duration: duration, timingFunction: timingFunction, layer: layer, size: size, color: color)
  }

}

// MARK: Small circle

private extension ActivityIndicatorAnimationBallClipRotatePulse {

  func animateSmallCircle(duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, layer: CALayer, size: CGSize, color: UIColor) {
    let animation = makeSmallCircleAnimation()
    let circleSize = size.width / 2
    let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: circleSize, height: circleSize), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - circleSize) / 2,
                       y: (layer.bounds.size.height - circleSize) / 2,
                       width: circleSize,
                       height: circleSize)
    circle.frame = frame
    circle.add(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

  func makeSmallCircleAnimation() -> CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath: .scale)
    animation.keyTimes = [0, 0.3, 1]
    animation.timingFunctions = [timingFunction, timingFunction]
    animation.values = [1, 0.3, 1]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

}

// MARK: Big circle

private extension ActivityIndicatorAnimationBallClipRotatePulse {

  func animateBigCircle(duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, layer: CALayer, size: CGSize, color: UIColor) {
    let animation = makeBigCircleAnimation()
    let circle = ActivityIndicatorShape.ringTwoHalfVertical.makeLayer(size: size, color: color)
    let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                       y: (layer.bounds.size.height - size.height) / 2,
                       width: size.width,
                       height: size.height)
    circle.frame = frame
    circle.add(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

  func makeBigCircleAnimation() -> CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, rotateAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: .scale)
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.timingFunctions = [timingFunction, timingFunction]
    scaleAnimation.values = [1, 0.6, 1]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var rotateAnimation: CAKeyframeAnimation {
    let rotateAnimation = CAKeyframeAnimation(keyPath: .rotationZ)
    rotateAnimation.keyTimes = scaleAnimation.keyTimes
    rotateAnimation.timingFunctions = [timingFunction, timingFunction]
    rotateAnimation.values = [0, CGFloat.pi, 2 * CGFloat.pi]
    rotateAnimation.duration = duration
    return rotateAnimation
  }

}
