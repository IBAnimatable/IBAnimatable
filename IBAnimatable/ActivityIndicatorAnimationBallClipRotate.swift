//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallClipRotate: ActivityIndicatorAnimating {

  // MARK: Properties

  private let duration: CFTimeInterval = 0.75

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let animation = self.animation

    // Draw circle
    let circle = ActivityIndicatorShape.RingThirdFour.createLayerWith(size: CGSize(width: size.width, height: size.height), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                       y: (layer.bounds.size.height - size.height) / 2,
                       width: size.width,
                       height: size.height)

    circle.frame = frame
    circle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallClipRotate {

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.values = [1, 0.6, 1]
    return scaleAnimation
  }

  var rotateAnimation: CAKeyframeAnimation {
    let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    rotateAnimation.keyTimes = scaleAnimation.keyTimes
    rotateAnimation.values = [0, M_PI, 2 * M_PI]
    return rotateAnimation
  }

  var animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, rotateAnimation]
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false
    return animation
  }
  
}
