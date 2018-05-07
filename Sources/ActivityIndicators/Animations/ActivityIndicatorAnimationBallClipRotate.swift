//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallClipRotate: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 0.75

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {

    // Draw circle
    let circle = ActivityIndicatorShape.ringThirdFour.makeLayer(size: CGSize(width: size.width, height: size.height), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                       y: (layer.bounds.size.height - size.height) / 2,
                       width: size.width,
                       height: size.height)

    circle.frame = frame
    circle.add(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallClipRotate {

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: .scale)
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.values = [1, 0.6, 1]
    return scaleAnimation
  }

  var rotateAnimation: CAKeyframeAnimation {
    let rotateAnimation = CAKeyframeAnimation(keyPath: .rotationZ)
    rotateAnimation.keyTimes = scaleAnimation.keyTimes
    rotateAnimation.values = [0, CGFloat.pi, 2 * CGFloat.pi]
    return rotateAnimation
  }

  var animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, rotateAnimation]
    animation.timingFunctionType = .linear
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

}
