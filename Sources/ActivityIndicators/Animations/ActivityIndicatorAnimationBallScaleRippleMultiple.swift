//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallScaleRippleMultiple: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 1.25
  fileprivate let timingFunction = CAMediaTimingFunction(controlPoints: 0.21, 0.53, 0.56, 0.8)

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let beginTime = layer.currentMediaTime
    let beginTimes = [0.0, 0.2, 0.4]

    let animation = defaultAnimation
    for i in 0 ..< 3 {
      let circle = ActivityIndicatorShape.ring.makeLayer(size: size, color: color)
      let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                         y: (layer.bounds.size.height - size.height) / 2,
                         width: size.width,
                         height: size.height)

      animation.beginTime = beginTime + beginTimes[i]
      circle.frame = frame
      circle.add(animation, forKey: "animation")
      layer.addSublayer(circle)
    }
  }
}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallScaleRippleMultiple {

  var defaultAnimation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, opacityAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: .scale)
    scaleAnimation.keyTimes = [0, 0.7]
    scaleAnimation.timingFunction = timingFunction
    scaleAnimation.values = [0, 1.0]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var opacityAnimation: CAKeyframeAnimation {
    let opacityAnimation = CAKeyframeAnimation(keyPath: .opacity)
    opacityAnimation.keyTimes = [0, 0.7, 1]
    opacityAnimation.timingFunctions = [timingFunction, timingFunction]
    opacityAnimation.values = [1, 0.7, 0]
    opacityAnimation.duration = duration
    return opacityAnimation
  }

}
