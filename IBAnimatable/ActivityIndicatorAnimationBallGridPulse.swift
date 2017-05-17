//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallGridPulse: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let timingFunction: TimingFunctionType = .default

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSpacing: CGFloat = 2
    let circleSize = (size.width - circleSpacing * 2) / 3
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let durations: [CFTimeInterval] = [0.72, 1.02, 1.28, 1.42, 1.45, 1.18, 0.87, 1.45, 1.06]
    let beginTime = CACurrentMediaTime()
    let beginTimes: [CFTimeInterval] = [-0.06, 0.25, -0.17, 0.48, 0.31, 0.03, 0.46, 0.78, 0.45]

    // Draw circles
    for i in 0 ..< 3 {
      for j in 0 ..< 3 {
        let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: circleSize, height: circleSize), color: color)
        let frame = CGRect(x: x + circleSize * CGFloat(j) + circleSpacing * CGFloat(j),
                           y: y + circleSize * CGFloat(i) + circleSpacing * CGFloat(i),
                           width: circleSize,
                           height: circleSize)

        animation.duration = durations[3 * i + j]
        animation.beginTime = beginTime + beginTimes[3 * i + j]
        circle.frame = frame
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
      }
    }
  }
}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallGridPulse {

  var animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, opacityAnimation]
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.timingFunctionsType = [timingFunction, timingFunction]
    scaleAnimation.values = [1, 0.5, 1]
    return scaleAnimation
  }

  var opacityAnimation: CAKeyframeAnimation {
    let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
    opacityAnimation.keyTimes = [0, 0.5, 1]
    opacityAnimation.timingFunctionsType = [timingFunction, timingFunction]
    opacityAnimation.values = [1, 0.7, 1]
    return opacityAnimation
  }

}
