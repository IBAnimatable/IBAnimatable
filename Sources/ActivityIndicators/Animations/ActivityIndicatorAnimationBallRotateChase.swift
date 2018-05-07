//
//  Created by Tom Baranes on 23/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallRotateChase: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 1.5

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSize = size.width / 5
    for i in 0 ..< 5 {
      let factor = Float(i) * 1.0 / 5
      let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: circleSize, height: circleSize), color: color)
      let animation = rotateAnimation(rate: factor,
                                      x: layer.bounds.size.width / 2,
                                      y: layer.bounds.size.height / 2,
                                      size: CGSize(width: size.width - circleSize,
                                                   height: size.height - circleSize))

      circle.frame = CGRect(x: 0, y: 0, width: circleSize, height: circleSize)
      circle.add(animation, forKey: "animation")
      layer.addSublayer(circle)
    }
  }

}

// MARK: - Setup
// swiftlint:disable variable_name_min_length
private extension ActivityIndicatorAnimationBallRotateChase {
  func rotateAnimation(rate: Float, x: CGFloat, y: CGFloat, size: CGSize) -> CAAnimationGroup {
    let fromScale = 1 - rate
    let toScale = 0.2 + rate
    let timeFunc = CAMediaTimingFunction(controlPoints: 0.5, 0.15 + rate, 0.25, 1.0)
    let scaleAnimation = CABasicAnimation(keyPath: .scale)
    scaleAnimation.duration = duration
    scaleAnimation.repeatCount = .infinity
    scaleAnimation.fromValue = fromScale
    scaleAnimation.toValue = toScale

    let positionAnimation = CAKeyframeAnimation(keyPath: .position)
    positionAnimation.duration = duration
    positionAnimation.repeatCount = .infinity
    positionAnimation.path = UIBezierPath(arcCenter: CGPoint(x: x, y: y),
                                          radius: size.width / 2,
                                          startAngle: 3 * CGFloat.pi / 2,
                                          endAngle: 3 * CGFloat.pi / 2 + 2 * CGFloat.pi,
                                          clockwise: true).cgPath

    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, positionAnimation]
    animation.timingFunction = timeFunc
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }
}
// swiftlint:enable variable_name_min_length
