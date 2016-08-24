//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallRotate: ActivityIndicatorAnimating {

  // MARK: Properties

  private let duration: CFTimeInterval = 1
  private let timingFunction = CAMediaTimingFunction(controlPoints: 0.7, -0.13, 0.22, 0.86)

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSize: CGFloat = size.width / 5
    let animation = self.animation

    // Draw circles
    let leftCircle = ActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
    let rightCircle = ActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
    let centerCircle = ActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: circleSize, height: circleSize), color: color)

    leftCircle.opacity = 0.8
    leftCircle.frame = CGRect(x: 0, y: (size.height - circleSize) / 2, width: circleSize, height: circleSize)
    rightCircle.opacity = 0.8
    rightCircle.frame = CGRect(x: size.width - circleSize, y: (size.height - circleSize) / 2, width: circleSize, height: circleSize)
    centerCircle.frame = CGRect(x: (size.width - circleSize) / 2, y: (size.height - circleSize) / 2, width: circleSize, height: circleSize)

    let circle = CALayer()
    let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2, y: (layer.bounds.size.height - size.height) / 2, width: size.width, height: size.height)

    circle.frame = frame
    circle.addSublayer(leftCircle)
    circle.addSublayer(rightCircle)
    circle.addSublayer(centerCircle)
    circle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(circle)
  }
}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallRotate {

  var animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, rotateAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false
    return animation
  }

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.timingFunctions = [timingFunction, timingFunction]
    scaleAnimation.values = [1, 0.6, 1]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var rotateAnimation: CAKeyframeAnimation {
    let rotateAnimation = CAKeyframeAnimation(keyPath:"transform.rotation.z")
    rotateAnimation.keyTimes = [0, 0.5, 1]
    rotateAnimation.timingFunctions = [timingFunction, timingFunction]
    rotateAnimation.values = [0, M_PI, 2 * M_PI]
    rotateAnimation.duration = duration
    return rotateAnimation

  }
}
