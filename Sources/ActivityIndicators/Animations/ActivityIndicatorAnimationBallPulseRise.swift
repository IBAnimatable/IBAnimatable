//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallPulseRise: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 1
  fileprivate var deltaY: CGFloat = 0
  fileprivate let timingFunction = CAMediaTimingFunction(controlPoints: 0.15, 0.46, 0.9, 0.6)

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSpacing: CGFloat = 2
    let circleSize = (size.width - 4 * circleSpacing) / 5
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - circleSize) / 2
    deltaY = size.height / 2

    for i in 0 ..< 5 {
      let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: circleSize, height: circleSize), color: color)
      let frame = CGRect(x: x + circleSize * CGFloat(i) + circleSpacing * CGFloat(i),
                         y: y,
                         width: circleSize,
                         height: circleSize)

      circle.frame = frame
      if i % 2 == 0 {
        circle.add(evenAnimation, forKey: "animation")
      } else {
        circle.add(oddAnimation, forKey: "animation")
      }
      layer.addSublayer(circle)
    }
  }

}

// MARK: - Setup Odd

private extension ActivityIndicatorAnimationBallPulseRise {

  var oddAnimation: CAAnimation {
    let scaleAnimation = oddScaleAnimation
    let translateAnimation = oddTranslateAnimation
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, translateAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var oddScaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: .scale)
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.timingFunctions = [timingFunction, timingFunction]
    scaleAnimation.values = [0.4, 1.1, 0.75]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var oddTranslateAnimation: CAKeyframeAnimation {
    let translateAnimation = CAKeyframeAnimation(keyPath: .translationY)
    translateAnimation.keyTimes = [0, 0.25, 0.75, 1]
    translateAnimation.timingFunctions = [timingFunction, timingFunction, timingFunction]
    translateAnimation.values = [0, deltaY, -deltaY, 0]
    translateAnimation.duration = duration
    return translateAnimation
  }

}

// MARK: - Even Odd

private extension ActivityIndicatorAnimationBallPulseRise {

  var evenAnimation: CAAnimation {
    let scaleAnimation = evenScaleAnimation
    let translateAnimation = evenTranslateAnimation
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, translateAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var evenScaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: .scale)
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.timingFunctions = [timingFunction, timingFunction]
    scaleAnimation.values = [1.1, 0.4, 1]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var evenTranslateAnimation: CAKeyframeAnimation {
    let translateAnimation = CAKeyframeAnimation(keyPath: .translationY)
    translateAnimation.keyTimes = [0, 0.25, 0.75, 1]
    translateAnimation.timingFunctions = [timingFunction, timingFunction, timingFunction]
    translateAnimation.values = [0, -deltaY, deltaY, 0]
    translateAnimation.duration = duration
    return translateAnimation
  }

}
