//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationPacman: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 0.5
  fileprivate let circleDuration: CFTimeInterval = 1
  fileprivate var size: CGSize = .zero
  fileprivate let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    self.size = size
    animateCircle(in: layer, color: color)
    animatePacman(in: layer, color: color)
  }

}

// MARK: - Pacman

private extension ActivityIndicatorAnimationPacman {

  func animatePacman(in layer: CALayer, color: UIColor) {
    let pacmanSize = 2 * size.width / 3
    let pacman = ActivityIndicatorShape.pacman.makeLayer(size: CGSize(width: pacmanSize, height: pacmanSize), color: color)
    let animation = pacmanAnimation
    let frame = CGRect(
      x: (layer.bounds.size.width - size.width) / 2,
      y: (layer.bounds.size.height - size.height) / 2 + size.height / 2 - pacmanSize / 2,
      width: pacmanSize,
      height: pacmanSize
    )
    pacman.frame = frame
    pacman.add(animation, forKey: "animation")
    layer.addSublayer(pacman)
  }

  var pacmanAnimation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [strokeStartAnimation, strokeEndAnimation]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var strokeStartAnimation: CAKeyframeAnimation {
    let strokeStartAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
    strokeStartAnimation.keyTimes = [0, 0.5, 1]
    strokeStartAnimation.timingFunctions = [timingFunction, timingFunction]
    strokeStartAnimation.values = [0.125, 0, 0.125]
    strokeStartAnimation.duration = duration
    return strokeStartAnimation
  }

  var strokeEndAnimation: CAKeyframeAnimation {
    let strokeEndAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
    strokeEndAnimation.keyTimes = [0, 0.5, 1]
    strokeEndAnimation.timingFunctions = [timingFunction, timingFunction]
    strokeEndAnimation.values = [0.875, 1, 0.875]
    strokeEndAnimation.duration = duration
    return strokeEndAnimation
  }

}

// MARK: - Circle

private extension ActivityIndicatorAnimationPacman {

  func animateCircle(in layer: CALayer, color: UIColor) {
    let circleSize = size.width / 5
    let circle = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: circleSize, height: circleSize), color: color)
    let animation = circleAnimation
    let frame = CGRect(
      x: (layer.bounds.size.width - size.width) / 2 + size.width - circleSize,
      y: (layer.bounds.size.height - size.height) / 2 + size.height / 2 - circleSize
        / 2,
      width: circleSize,
      height: circleSize
    )

    circle.frame = frame
    circle.add(animation, forKey: "animation")
    layer.addSublayer(circle)
  }

  var circleAnimation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [translateAnimation, opacityAnimation]
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.duration = circleDuration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  var translateAnimation: CABasicAnimation {
    let translateAnimation = CABasicAnimation(keyPath: "transform.translation.x")
    translateAnimation.fromValue = 0
    translateAnimation.toValue = -size.width / 2
    translateAnimation.duration = circleDuration
    return translateAnimation
  }

  var opacityAnimation: CABasicAnimation {
    let opacityAnimation = CABasicAnimation(keyPath: "opacity")
    opacityAnimation.fromValue = 1
    opacityAnimation.toValue = 0.7
    opacityAnimation.duration = circleDuration
    return opacityAnimation
  }

}
