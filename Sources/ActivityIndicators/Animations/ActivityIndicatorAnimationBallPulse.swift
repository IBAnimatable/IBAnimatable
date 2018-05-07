//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallPulse: ActivityIndicatorAnimating {

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSpacing: CGFloat = 2
    let circleSize: CGFloat = (size.width - 2 * circleSpacing) / 3
    let x: CGFloat = (layer.bounds.size.width - size.width) / 2
    let y: CGFloat = (layer.bounds.size.height - circleSize) / 2
    let beginTime = layer.currentMediaTime
    let beginTimes: [CFTimeInterval] = [0.12, 0.24, 0.36]
    let animation = defaultAnimation

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

private extension ActivityIndicatorAnimationBallPulse {

  var defaultAnimation: CAKeyframeAnimation {
    let duration: CFTimeInterval = 0.75
    let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)
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
