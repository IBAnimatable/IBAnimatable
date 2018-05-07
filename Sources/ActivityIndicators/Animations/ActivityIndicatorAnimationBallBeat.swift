//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallBeat: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 0.7

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSpacing: CGFloat = 2
    let circleSize = (size.width - circleSpacing * 2) / 3
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - circleSize) / 2
    let beginTime = layer.currentMediaTime
    let beginTimes = [0.35, 0, 0.35]

    // Draw circles
    for i in 0 ..< 3 {
      let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: circleSize, height: circleSize), color: color)
      let frame = CGRect(x: x + circleSize * CGFloat(i) + circleSpacing * CGFloat(i),
                         y: y,
                         width: circleSize,
                         height: circleSize)
      animation.beginTime = beginTime + beginTimes[i]
      circle.frame = frame
      circle.add(animation, forKey: "animation")
      layer.addSublayer(circle)
    }
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallBeat {

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: .scale)
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.values = [1, 0.75, 1]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var opacityAnimation: CAKeyframeAnimation {
    let opacityAnimation = CAKeyframeAnimation(keyPath: .opacity)
    opacityAnimation.keyTimes = [0, 0.5, 1]
    opacityAnimation.values = [1, 0.2, 1]
    opacityAnimation.duration = duration
    return opacityAnimation
  }

  var animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, opacityAnimation]
    animation.timingFunctionType = .linear
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

}
