//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallScaleMultiple: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 1

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0, 0.2, 0.4]

        for i in 0 ..< 3 {
            let circle = ActivityIndicatorShape.circle.makeLayer(size: size, color: color)
            let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                y: (layer.bounds.size.height - size.height) / 2,
                width: size.width,
                height: size.height)

            animation.beginTime = beginTime + beginTimes[i]
            circle.frame = frame
            circle.opacity = 0
            circle.add(animation, forKey: "animation")
            layer.addSublayer(circle)
        }
    }
}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallScaleMultiple {

  var animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, opacityAnimation]
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var scaleAnimation: CABasicAnimation {
    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
    scaleAnimation.duration = duration
    scaleAnimation.fromValue = 0
    scaleAnimation.toValue = 1
    return scaleAnimation
  }

  var opacityAnimation: CAKeyframeAnimation {
    let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
    opacityAnimation.duration = duration
    opacityAnimation.keyTimes = [0, 0.05, 1]
    opacityAnimation.values = [0, 1, 0]
    return opacityAnimation
  }

}
