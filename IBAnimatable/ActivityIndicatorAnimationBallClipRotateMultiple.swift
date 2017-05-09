//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallClipRotateMultiple: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 0.7

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let bigCircleSize: CGFloat = size.width
    let smallCircleSize: CGFloat = size.width / 2
    let longDuration: CFTimeInterval = 1
    let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    let circleLayer1 = makeCircleLayerOf(shape: .ringTwoHalfHorizontal,
             duration: longDuration,
             timingFunction: timingFunction,
             layerSize: layer.frame.size,
             size: bigCircleSize,
             color: color, reverse: false)
    let circleLayer2 = makeCircleLayerOf(shape: .ringTwoHalfVertical,
             duration: longDuration,
             timingFunction: timingFunction,
             layerSize: layer.frame.size,
             size: smallCircleSize,
             color: color, reverse: true)
    layer.addSublayer(circleLayer1)
    layer.addSublayer(circleLayer2)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallClipRotateMultiple {

  func makeAnimation(duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, reverse: Bool) -> CAAnimation {
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
      rotateAnimation.values = [0, CGFloat.pi, 2 * CGFloat.pi]
    } else {
      rotateAnimation.values = [0, -CGFloat.pi, -2 * CGFloat.pi]
    }
    rotateAnimation.duration = duration

    // Animation
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, rotateAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false

    return animation
  }

  // swiftlint:disable:next function_parameter_count
  func makeCircleLayerOf(shape: ActivityIndicatorShape,
                         duration: CFTimeInterval, timingFunction: CAMediaTimingFunction,
                         layerSize: CGSize, size: CGFloat,
                         color: UIColor, reverse: Bool) -> CALayer {
    let circleLayer = shape.makeLayer(size: CGSize(width: size, height: size), color: color)
    let frame = CGRect(x: (layerSize.width - size) / 2,
                       y: (layerSize.height - size) / 2,
                       width: size,
                       height: size)
    let animation = makeAnimation(duration: duration, timingFunction: timingFunction, reverse: reverse)

    circleLayer.frame = frame
    circleLayer.add(animation, forKey: "animation")

    return circleLayer
  }

}
