//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallGridBeat: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let timingFunction: TimingFunctionType = .default

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSpacing: CGFloat = 2
    let circleSize = (size.width - circleSpacing * 2) / 3
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let durations = [0.96, 0.93, 1.19, 1.13, 1.34, 0.94, 1.2, 0.82, 1.19]
    let beginTime = layer.currentMediaTime
    let beginTimes = [0.36, 0.4, 0.68, 0.41, 0.71, -0.15, -0.12, 0.01, 0.32]
    let animation = defaultAnimation

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

private extension ActivityIndicatorAnimationBallGridBeat {

  var defaultAnimation: CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath: .opacity)
    animation.keyTimes = [0, 0.5, 1]
    animation.timingFunctionsType = [timingFunction, timingFunction]
    animation.values = [1, 0.7, 1]
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

}
