//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationTriangleSkewSpin: ActivityIndicatorAnimating {

  // MARK: Properties

  private let duration: CFTimeInterval = 3

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let triangle = ActivityIndicatorShape.Triangle.createLayerWith(size: size, color: color)
    let animation = self.animation
    triangle.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
    triangle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(triangle)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationTriangleSkewSpin {

  var animation: CAKeyframeAnimation {
    let timingFunction = CAMediaTimingFunction(controlPoints: 0.09, 0.57, 0.49, 0.9)
    let animation = CAKeyframeAnimation(keyPath: "transform")
    animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
    animation.timingFunctions = [timingFunction, timingFunction, timingFunction, timingFunction]
    animation.values = [
      NSValue(CATransform3D: CATransform3DConcat(createRotateXTransform(angle: 0), createRotateYTransform(angle: 0))),
      NSValue(CATransform3D: CATransform3DConcat(createRotateXTransform(angle: CGFloat(M_PI)), createRotateYTransform(angle: 0))),
      NSValue(CATransform3D: CATransform3DConcat(createRotateXTransform(angle: CGFloat(M_PI)), createRotateYTransform(angle: CGFloat(M_PI)))),
      NSValue(CATransform3D: CATransform3DConcat(createRotateXTransform(angle: 0), createRotateYTransform(angle: CGFloat(M_PI)))),
      NSValue(CATransform3D: CATransform3DConcat(createRotateXTransform(angle: 0), createRotateYTransform(angle: 0)))]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false
    return animation
  }

  func createRotateXTransform(angle angle: CGFloat) -> CATransform3D {
    var transform = CATransform3DMakeRotation(angle, 1, 0, 0)

    transform.m34 = CGFloat(-1) / 100

    return transform
  }

  func createRotateYTransform(angle angle: CGFloat) -> CATransform3D {
    var transform = CATransform3DMakeRotation(angle, 0, 1, 0)

    transform.m34 = CGFloat(-1) / 100

    return transform
  }
  
}
