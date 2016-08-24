//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationSemiCircleSpin: ActivityIndicatorAnimating {

  // MARK: Properties

  private let duration: CFTimeInterval = 0.6

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let animation = self.animation
    let circle = ActivityIndicatorShape.CircleSemi.createLayerWith(size: size, color: color)
    let frame = CGRect(
      x: (layer.bounds.width - size.width) / 2,
      y: (layer.bounds.height - size.height) / 2,
      width: size.width,
      height: size.height
    )
    circle.frame = frame
    circle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(circle)
  }
}

// MARK: - Setup

private extension ActivityIndicatorAnimationSemiCircleSpin {

  var animation: CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    animation.keyTimes = [0, 0.5, 1]
    animation.values = [0, M_PI, 2 * M_PI]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false
    return animation
  }
}
