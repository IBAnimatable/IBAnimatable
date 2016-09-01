//
//  Created by Tom Baranes on 23/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationOrbit: ActivityIndicatorAnimating {

  // MARK: Properties

  let duration: CFTimeInterval = 1.9
  let satelliteCoreRatio: CGFloat = 0.25
  let distanceRatio: CGFloat = 1.5
  var coreSize: CGFloat = 0
  var satelliteSize: CGFloat = 0
  var size: CGSize = .zero

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    self.size = size

    coreSize = size.width / (1 + satelliteCoreRatio + distanceRatio)
    satelliteSize = coreSize * satelliteCoreRatio
    ring1InLayer(layer, color: color)
    ring2InLayer(layer, color: color)
    coreInLayer(layer, color: color)
    satelliteInLayer(layer, color: color)
  }

}

// MARK: - Satellite

private extension ActivityIndicatorAnimationOrbit {

  func satelliteInLayer(layer: CALayer, color: UIColor) {
    let rotateAnimation = createSatelliteRotateAnimation(layer)
    let circle = ActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: satelliteSize, height: satelliteSize), color: color)

    let frame = CGRect(x: 0, y: 0, width: satelliteSize, height: satelliteSize)
    circle.frame = frame
    circle.addAnimation(rotateAnimation, forKey: "animation")
    layer.addSublayer(circle)
  }

  func createSatelliteRotateAnimation(layer: CALayer) -> CAKeyframeAnimation {
    let rotateAnimation = CAKeyframeAnimation(keyPath: "position")
    rotateAnimation.path = UIBezierPath(arcCenter: CGPoint(x: layer.bounds.midX, y: layer.bounds.midY),
                                        radius: (size.width - satelliteSize) / 2,
                                        startAngle: CGFloat(M_PI) * 1.5,
                                        endAngle: CGFloat(M_PI) * 1.5 + 4 * CGFloat(M_PI),
                                        clockwise: true).CGPath
    rotateAnimation.duration = duration * 2
    rotateAnimation.repeatCount = .infinity
    rotateAnimation.removedOnCompletion = false
    return rotateAnimation
  }

}

// MARK: - Core

private extension ActivityIndicatorAnimationOrbit {

  func coreInLayer(layer: CALayer, color: UIColor) {
    let circle = ActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: coreSize, height: coreSize), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - coreSize) / 2,
                       y: (layer.bounds.size.height - coreSize) / 2,
                       width: coreSize,
                       height: coreSize)
    circle.frame = frame
    circle.addAnimation(coreScaleAnimation, forKey: "animation")
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
    scaleAnimation.removedOnCompletion = false
    return scaleAnimation
  }
}

// MARK: - Ring 1

private extension ActivityIndicatorAnimationOrbit {

  func ring1InLayer(layer: CALayer, color: UIColor) {
    let animation = ring1Animation
    let circle = ActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: coreSize, height: coreSize), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - coreSize) / 2,
                       y: (layer.bounds.size.height - coreSize) / 2,
                       width: coreSize,
                       height: coreSize)
    circle.frame = frame
    circle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

  var ring1Animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [ring1ScaleAnimation, ring1OpacityAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false
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

  func ring2InLayer(layer: CALayer, color: UIColor) {
    let animation = ring2Animation
    let circle = ActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: coreSize, height: coreSize), color: color)
    let frame = CGRect(x: (layer.bounds.size.width - coreSize) / 2,
                       y: (layer.bounds.size.height - coreSize) / 2,
                       width: coreSize,
                       height: coreSize)
    circle.frame = frame
    circle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

  var ring2Animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [ring2ScaleAnimation, ring2OpacityAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false
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
