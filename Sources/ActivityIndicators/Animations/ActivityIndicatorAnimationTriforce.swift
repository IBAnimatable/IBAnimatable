//
//  ActivityIndicatorAnimationTriforce.swift
//  IBAnimatable
//
//  Created by phimage on 02/05/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationTriforce: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 3 / 2
  #if TRIFORCE
  public var trueColor = true
  #else
  public var trueColor = false
  #endif
  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2

    let triforceSize = CGSize(width: size.width / 2, height: size.height)
    let power = ActivityIndicatorShape.triangle.makeLayer(size: triforceSize, color: trueColor ? .red: color)
    power.frame = CGRect(x: layer.bounds.size.width / 4, y: -layer.bounds.size.height / 2, width: triforceSize.width, height: triforceSize.height)
    power.add(defaultAnimation, forKey: "animation")
    layer.addSublayer(power)
    let wisdom = ActivityIndicatorShape.triangle.makeLayer(size: triforceSize, color: trueColor ? .blue: color)
    wisdom.frame = CGRect(x: x, y: y, width: triforceSize.width, height: triforceSize.height)
    wisdom.add(defaultAnimation, forKey: "animation")
    layer.addSublayer(wisdom)
    let courage = ActivityIndicatorShape.triangle.makeLayer(size: triforceSize, color: trueColor ? .green: color)
    courage.frame = CGRect(x: layer.bounds.size.width / 2, y: y, width: triforceSize.width, height: triforceSize.height)
    courage.add(defaultAnimation, forKey: "animation")
    layer.addSublayer(courage)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationTriforce {

  var defaultAnimation: CAKeyframeAnimation {
    let timingFunction: TimingFunctionType = .linear
    let animation = CAKeyframeAnimation(keyPath: .transform)
    animation.keyTimes = [0, 1]
    animation.timingFunctionsType = [timingFunction, timingFunction]
    animation.values = [
      NSValue(caTransform3D: CATransform3DMakeRotation(0, 0, 1, 0)),
      NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat.pi, 0, 1, 0))
    ]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

}
