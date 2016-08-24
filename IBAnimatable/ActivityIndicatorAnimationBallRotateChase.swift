//
//  Created by Tom Baranes on 23/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallRotateChase: ActivityIndicatorAnimating {

  // MARK: Properties

  private let duration: CFTimeInterval = 1.5

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSize = size.width / 5
    for i in 0 ..< 5 {
      let factor = Float(i) * 1.0 / 5
      let circle = ActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
      let animation = rotateAnimation(factor, x: layer.bounds.size.width / 2, y: layer.bounds.size.height / 2, size: CGSize(width: size.width - circleSize, height: size.height - circleSize))

      circle.frame = CGRect(x: 0, y: 0, width: circleSize, height: circleSize)
      circle.addAnimation(animation, forKey: "animation")
      layer.addSublayer(circle)
    }
  }

}


// MARK: - Setup

private extension ActivityIndicatorAnimationBallRotateChase {

  func rotateAnimation(rate: Float, x: CGFloat, y: CGFloat, size: CGSize) -> CAAnimationGroup {
    let fromScale = 1 - rate
    let toScale = 0.2 + rate
    let timeFunc = CAMediaTimingFunction(controlPoints: 0.5, 0.15 + rate, 0.25, 1.0)
    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
    scaleAnimation.duration = duration
    scaleAnimation.repeatCount = .infinity
    scaleAnimation.fromValue = fromScale
    scaleAnimation.toValue = toScale

    let positionAnimation = CAKeyframeAnimation(keyPath: "position")
    positionAnimation.duration = duration
    positionAnimation.repeatCount = .infinity
    positionAnimation.path = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: size.width / 2, startAngle: 3 * CGFloat(M_PI) * 0.5, endAngle: 3 * CGFloat(M_PI) * 0.5 + 2 * CGFloat(M_PI), clockwise: true).CGPath

    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, positionAnimation]
    animation.timingFunction = timeFunc
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false
    return animation
  }

}
