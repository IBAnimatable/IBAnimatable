//
//  ActivityIndicatorAnimationRupee.swift
//  IBAnimatable
//
//  Created by phimage on 07/05/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationRupee: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 1
  fileprivate let maskType: MaskType = .polygon(sides: 6)

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let maskSpacing: CGFloat = -2
    let maskSize = (size.width - 4 * maskSpacing) / 5
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let beginTime = layer.currentMediaTime
    let beginTimes: [CFTimeInterval] = [0.0, 0.5, 0.0, 0.5, 0.0, 0.0, 0.5, 0.0]
    let animation = defaultAnimation

    // Draw shapes
    for i in 0 ..< 8 where i % 4 != 0 {  // remove left and right
      let shapeLayer = makeLayer(angle: .pi / 4 * CGFloat(i),
                                 size: maskSize,
                                 origin: CGPoint(x: x, y: y),
                                 containerSize: size,
                                 color: color)
      animation.beginTime = beginTime + beginTimes[i]
      shapeLayer.add(animation, forKey: "animation")
      layer.addSublayer(shapeLayer)
    }
  }

  func makeLayer(angle: CGFloat, size: CGFloat, origin: CGPoint, containerSize: CGSize, color: UIColor) -> CALayer {
    let radius = containerSize.width / 2 - size / 2
    let layer = ActivityIndicatorShape.mask(type: maskType).makeLayer(size: CGSize(width: size, height: size), color: color)
    let frame = CGRect(
      x: origin.x + radius * (cos(angle) + 1),
      y: origin.y + radius * (sin(angle) + 1),
      width: size,
      height: size)
    layer.frame = frame
    return layer
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationRupee {

  var defaultAnimation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, opacityAnimation]
    animation.timingFunctionType = .linear
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: .scale)
    scaleAnimation.keyTimes = [0, 0.5, 1]
    scaleAnimation.values = [1, 0.4, 1]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var opacityAnimation: CAKeyframeAnimation {
    let opacityAnimation = CAKeyframeAnimation(keyPath: .opacity)
    opacityAnimation.keyTimes = [0, 0.5, 1]
    opacityAnimation.values = [1, 0.3, 1]
    opacityAnimation.duration = duration
    return opacityAnimation
  }

}
