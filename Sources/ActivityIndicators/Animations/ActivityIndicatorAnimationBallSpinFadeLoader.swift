//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallSpinFadeLoader: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 1

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {

    let circleSpacing: CGFloat = -2
    let circleSize = (size.width - 4 * circleSpacing) / 5
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let beginTime = CACurrentMediaTime()
    let beginTimes: [CFTimeInterval] = [0, 0.12, 0.24, 0.36, 0.48, 0.6, 0.72, 0.84]

    // Draw circles
    for i in 0 ..< 8 {
      let circle = makeCircleLayer(angle: CGFloat.pi / 4 * CGFloat(i),
                            size: circleSize,
                            origin: CGPoint(x: x, y: y),
                            containerSize: size,
                            color: color)

      animation.beginTime = beginTime + beginTimes[i]
      circle.add(animation, forKey: "animation")
      layer.addSublayer(circle)
    }
  }

  func makeCircleLayer(angle: CGFloat, size: CGFloat, origin: CGPoint, containerSize: CGSize, color: UIColor) -> CALayer {
    let radius = containerSize.width / 2 - size / 2
    let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: size, height: size), color: color)
    let frame = CGRect(
      x: origin.x + radius * (cos(angle) + 1),
      y: origin.y + radius * (sin(angle) + 1),
      width: size,
      height: size)

    circle.frame = frame

    return circle
  }
}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallSpinFadeLoader {

  var animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, opacityAnimation]
    animation.timingFunctionType = .linear
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.values = [1, 0.4, 1]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var opacityAnimation: CAKeyframeAnimation {
    let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
    opacityAnimation.keyTimes = [0, 0.5, 1]
    opacityAnimation.values = [1, 0.3, 1]
    opacityAnimation.duration = duration
    return opacityAnimation
  }

}
