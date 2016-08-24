//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallClipRotateMultiple: ActivityIndicatorAnimating {

  // MARK: Properties

  private let duration: CFTimeInterval = 0.7

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let bigCircleSize: CGFloat = size.width
    let smallCircleSize: CGFloat = size.width / 2
    let longDuration: CFTimeInterval = 1
    let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    circleOf(shape: .RingTwoHalfHorizontal,
             duration: longDuration,
             timingFunction: timingFunction,
             layer: layer,
             size: bigCircleSize,
             color: color, reverse: false)
    circleOf(shape: .RingTwoHalfVertical,
             duration: longDuration,
             timingFunction: timingFunction,
             layer: layer,
             size: smallCircleSize,
             color: color, reverse: true)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallClipRotateMultiple {

  func createAnimationIn(duration duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, reverse: Bool) -> CAAnimation {
    // Scale animation
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.timingFunctions = [timingFunction, timingFunction]
    scaleAnimation.values = [1, 0.6, 1]
    scaleAnimation.duration = duration

    // Rotate animation
    let rotateAnimation = CAKeyframeAnimation(keyPath:"transform.rotation.z")
    rotateAnimation.keyTimes = scaleAnimation.keyTimes
    rotateAnimation.timingFunctions = [timingFunction, timingFunction]
    if !reverse {
      rotateAnimation.values = [0, M_PI, 2 * M_PI]
    } else {
      rotateAnimation.values = [0, -M_PI, -2 * M_PI]
    }
    rotateAnimation.duration = duration

    // Animation
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, rotateAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false

    return animation
  }

  // swiftlint:disable:next function_parameter_count
  func circleOf(shape shape: ActivityIndicatorShape, duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, layer: CALayer, size: CGFloat, color: UIColor, reverse: Bool) {
    let circle = shape.createLayerWith(size: CGSize(width: size, height: size), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - size) / 2,
                       y: (layer.bounds.size.height - size) / 2,
                       width: size,
                       height: size)
    let animation = createAnimationIn(duration: duration, timingFunction: timingFunction, reverse: reverse)

    circle.frame = frame
    circle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

}
