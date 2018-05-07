//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallZigZag: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 0.7

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSize: CGFloat = size.width / 5
    let deltaX = size.width / 2 - circleSize / 2
    let deltaY = size.height / 2 - circleSize / 2
    let frame = CGRect(x: (layer.bounds.size.width - circleSize) / 2,
                       y: (layer.bounds.size.height - circleSize) / 2,
                       width: circleSize,
                       height: circleSize)

    // Circle 1 animation
    let animation = CAKeyframeAnimation(keyPath: .transform)
    animation.keyTimes = [0.0, 0.33, 0.66, 1.0]
    animation.timingFunctionType = .linear
    animation.values = [NSValue(caTransform3D: CATransform3DMakeTranslation(0, 0, 0)),
                        NSValue(caTransform3D: CATransform3DMakeTranslation(-deltaX, -deltaY, 0)),
                        NSValue(caTransform3D: CATransform3DMakeTranslation(deltaX, -deltaY, 0)),
                        NSValue(caTransform3D: CATransform3DMakeTranslation(0, 0, 0))]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    let circle1 = makeCircleLayer(frame: frame, size: CGSize(width: circleSize, height: circleSize), color: color, animation: animation)
    layer.addSublayer(circle1)

    // Circle 2 animation
    animation.values = [NSValue(caTransform3D: CATransform3DMakeTranslation(0, 0, 0)),
                        NSValue(caTransform3D: CATransform3DMakeTranslation(deltaX, deltaY, 0)),
                        NSValue(caTransform3D: CATransform3DMakeTranslation(-deltaX, deltaY, 0)),
                        NSValue(caTransform3D: CATransform3DMakeTranslation(0, 0, 0))]
    let circle2 = makeCircleLayer(frame: frame, size: CGSize(width: circleSize, height: circleSize), color: color, animation: animation)
    layer.addSublayer(circle2)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallZigZag {

  func makeCircleLayer(frame: CGRect, size: CGSize, color: UIColor, animation: CAAnimation) -> CALayer {
    let circle = ActivityIndicatorShape.circle.makeLayer(size: size, color: color)
    circle.frame = frame
    circle.add(animation, forKey: "animation")
    return circle
  }

}
