//
//  Created by Tom Baranes on 23/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationOrbit: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 1.9
  fileprivate let satelliteCoreRatio: CGFloat = 0.25
  fileprivate let distanceRatio: CGFloat = 1.5
  fileprivate var coreSize: CGFloat = 0
  fileprivate var satelliteSize: CGFloat = 0
  fileprivate var size: CGSize = .zero

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    self.size = size

    coreSize = size.width / (1 + satelliteCoreRatio + distanceRatio)
    satelliteSize = coreSize * satelliteCoreRatio
    animateRing1(in: layer, color: color)
    animateRing2(in: layer, color: color)
    animateCore(in: layer, color: color)
    animateSatellite(in: layer, color: color)
  }

}

// MARK: - Satellite

private extension ActivityIndicatorAnimationOrbit {

  func animateSatellite(in layer: CALayer, color: UIColor) {
    let rotateAnimation = makeSatelliteRotateAnimation(layer: layer)
    let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: satelliteSize, height: satelliteSize), color: color)

    let frame = CGRect(x: 0, y: 0, width: satelliteSize, height: satelliteSize)
    circle.frame = frame
    circle.add(rotateAnimation, forKey: "animation")
    layer.addSublayer(circle)
  }

  func makeSatelliteRotateAnimation(layer: CALayer) -> CAKeyframeAnimation {
    let rotateAnimation = CAKeyframeAnimation(keyPath: "position")
    rotateAnimation.path = UIBezierPath(arcCenter: CGPoint(x: layer.bounds.midX, y: layer.bounds.midY),
                                        radius: (size.width - satelliteSize) / 2,
                                        startAngle: CGFloat.pi * 1.5,
                                        endAngle: CGFloat.pi * 1.5 + 4 * CGFloat.pi,
                                        clockwise: true).cgPath
    rotateAnimation.duration = duration * 2
    rotateAnimation.repeatCount = .infinity
    rotateAnimation.isRemovedOnCompletion = false
    return rotateAnimation
  }

}

// MARK: - Core

private extension ActivityIndicatorAnimationOrbit {

  func animateCore(in layer: CALayer, color: UIColor) {
    let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: coreSize, height: coreSize), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - coreSize) / 2,
                       y: (layer.bounds.size.height - coreSize) / 2,
                       width: coreSize,
                       height: coreSize)
    circle.frame = frame
    circle.add(coreScaleAnimation, forKey: "animation")
    layer.addSublayer(circle)
  }

  var coreScaleAnimation: CAKeyframeAnimation {
    let inTimingFunction = CAMediaTimingFunction(controlPoints: 0.7, 0, 1, 0.5)
    let outTimingFunction = CAMediaTimingFunction(controlPoints: 0, 0.7, 0.5, 1)
    let standByTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = [0, 0.45, 0.55, 1]
    scaleAnimation.timingFunctions = [inTimingFunction, standByTimingFunction, outTimingFunction]
    scaleAnimation.values = [1, 1.3, 1.3, 1]
    scaleAnimation.duration = duration
    scaleAnimation.repeatCount = .infinity
    scaleAnimation.isRemovedOnCompletion = false
    return scaleAnimation
  }
}

// MARK: - Ring 1

private extension ActivityIndicatorAnimationOrbit {

  func animateRing1(in layer: CALayer, color: UIColor) {
    let animation = ring1Animation
    let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: coreSize, height: coreSize), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - coreSize) / 2,
                       y: (layer.bounds.size.height - coreSize) / 2,
                       width: coreSize,
                       height: coreSize)
    circle.frame = frame
    circle.add(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

  var ring1Animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [ring1ScaleAnimation, ring1OpacityAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var ring1ScaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = [0, 0.45, 0.45, 1]
    scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    scaleAnimation.values = [0, 0, 1.3, 2]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var ring1OpacityAnimation: CAKeyframeAnimation {
    let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
    let timingFunction = CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
    opacityAnimation.keyTimes = [0, 0.45, 1]
    ring1ScaleAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear), timingFunction]
    opacityAnimation.values = [0.8, 0.8, 0]
    opacityAnimation.duration = duration
    return opacityAnimation
  }

}

// MARK: - Ring 2

private extension ActivityIndicatorAnimationOrbit {

  func animateRing2(in layer: CALayer, color: UIColor) {
    let animation = ring2Animation
    let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: coreSize, height: coreSize), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - coreSize) / 2,
                       y: (layer.bounds.size.height - coreSize) / 2,
                       width: coreSize,
                       height: coreSize)
    circle.frame = frame
    circle.add(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

  var ring2Animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [ring2ScaleAnimation, ring2OpacityAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var ring2ScaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = [0, 0.55, 0.55, 1]
    scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    scaleAnimation.values = [0, 0, 1.3, 2.1]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var ring2OpacityAnimation: CAKeyframeAnimation {
    let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
    let timingFunction = CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
    opacityAnimation.keyTimes = [0, 0.55, 0.65, 1]
    ring2ScaleAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear), timingFunction]
    opacityAnimation.values = [0.7, 0.7, 0, 0]
    opacityAnimation.duration = duration
    return opacityAnimation
  }

}
