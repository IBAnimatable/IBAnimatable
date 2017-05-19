//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationSquareSpin: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 3

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let square = ActivityIndicatorShape.rectangle.makeLayer(size: size, color: color)
    let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                       y: (layer.bounds.size.height - size.height) / 2,
                       width: size.width,
                       height: size.height)
    square.frame = frame
    square.add(defaultAnimation, forKey: "animation")
    layer.addSublayer(square)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationSquareSpin {

  var defaultAnimation: CAKeyframeAnimation {
    let timingFunction = CAMediaTimingFunction(controlPoints: 0.09, 0.57, 0.49, 0.9)
    let animation = CAKeyframeAnimation(keyPath: "transform")
    animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
    animation.timingFunctions = [timingFunction, timingFunction, timingFunction, timingFunction]
    animation.values = [
      NSValue(caTransform3D: CATransform3DConcat(makeRotateXTransform(angle: 0), makeRotateYTransform(angle: 0))),
      NSValue(caTransform3D: CATransform3DConcat(makeRotateXTransform(angle: CGFloat.pi), makeRotateYTransform(angle: 0))),
      NSValue(caTransform3D: CATransform3DConcat(makeRotateXTransform(angle: CGFloat.pi), makeRotateYTransform(angle: CGFloat.pi))),
      NSValue(caTransform3D: CATransform3DConcat(makeRotateXTransform(angle: 0), makeRotateYTransform(angle: CGFloat.pi))),
      NSValue(caTransform3D: CATransform3DConcat(makeRotateXTransform(angle: 0), makeRotateYTransform(angle: 0)))]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  func makeRotateXTransform(angle: CGFloat) -> CATransform3D {
    var transform = CATransform3DMakeRotation(angle, 1, 0, 0)
    transform.m34 = CGFloat(-1) / 100
    return transform
  }

  func makeRotateYTransform(angle: CGFloat) -> CATransform3D {
    var transform = CATransform3DMakeRotation(angle, 0, 1, 0)
    transform.m34 = CGFloat(-1) / 100
    return transform
  }

}
