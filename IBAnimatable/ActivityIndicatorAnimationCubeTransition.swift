//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationCubeTransition: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 1.6
  fileprivate let timingFunction: TimingFunctionType = .easeInOut
  fileprivate let keyTimes: [NSNumber] = [0, 0.25, 0.5, 0.75, 1]
  fileprivate var deltaX: CGFloat = 0
  fileprivate var deltaY: CGFloat = 0

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {

    let squareSize = size.width / 5
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let beginTime = CACurrentMediaTime()
    let beginTimes: [CFTimeInterval] = [0, -0.8]
    deltaX = size.width - squareSize
    deltaY = size.height - squareSize

    for i in 0 ..< 2 {
      let square = ActivityIndicatorShape.rectangle.makeLayer(size: CGSize(width: squareSize, height: squareSize), color: color)
      let frame = CGRect(x: x, y: y, width: squareSize, height: squareSize)

      animation.beginTime = beginTime + beginTimes[i]
      square.frame = frame
      square.add(animation, forKey: "animation")
      layer.addSublayer(square)
    }
  }
}

// MARK: - Setup

private extension ActivityIndicatorAnimationCubeTransition {

  var animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, translateAnimation, rotateAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var rotateAnimation: CAKeyframeAnimation {
    let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    rotateAnimation.keyTimes = keyTimes
    rotateAnimation.timingFunctionsType = [timingFunction, timingFunction, timingFunction, timingFunction]
    rotateAnimation.values = [0, -CGFloat.pi / 2, -CGFloat.pi, -1.5 * CGFloat.pi, -2 * CGFloat.pi]
    rotateAnimation.duration = duration
    return rotateAnimation
  }

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = keyTimes
    scaleAnimation.timingFunctionsType = [timingFunction, timingFunction, timingFunction, timingFunction]
    scaleAnimation.values = [1, 0.5, 1, 0.5, 1]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var translateAnimation: CAKeyframeAnimation {
    let translateAnimation = CAKeyframeAnimation(keyPath: "transform.translation")
    translateAnimation.keyTimes = keyTimes
    translateAnimation.timingFunctionsType = [timingFunction, timingFunction, timingFunction, timingFunction]
    translateAnimation.values = [
      NSValue(cgSize: CGSize(width: 0, height: 0)),
      NSValue(cgSize: CGSize(width: deltaX, height: 0)),
      NSValue(cgSize: CGSize(width: deltaX, height: deltaY)),
      NSValue(cgSize: CGSize(width: 0, height: deltaY)),
      NSValue(cgSize: CGSize(width: 0, height: 0))
    ]
    translateAnimation.duration = duration
    return translateAnimation
  }

}
