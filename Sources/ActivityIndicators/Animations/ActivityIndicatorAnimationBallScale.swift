//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallScale: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 1

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circle = ActivityIndicatorShape.circle.makeLayer(size: size, color: color)
    circle.frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                          y: (layer.bounds.size.height - size.height) / 2,
                          width: size.width,
                          height: size.height)
    circle.add(animation, forKey: "animation")
    layer.addSublayer(circle)
  }
}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallScale {

  var animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, opacityAnimation]
    animation.timingFunctionType = .easeInOut
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var scaleAnimation: CABasicAnimation {
    let scaleAnimation = CABasicAnimation(keyPath: .scale)
    scaleAnimation.duration = duration
    scaleAnimation.fromValue = 0
    scaleAnimation.toValue = 1
    return scaleAnimation
  }

  var opacityAnimation: CABasicAnimation {
    let opacityAnimation = CABasicAnimation(keyPath: .opacity)
    opacityAnimation.duration = duration
    opacityAnimation.fromValue = 1
    opacityAnimation.toValue = 0
    return opacityAnimation
  }

}
