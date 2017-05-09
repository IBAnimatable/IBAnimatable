//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

// swiftlint:disable file_length
private typealias AnimationValues = (x: CGFloat, y: CGFloat, scaleX: CGFloat, scaleY: CGFloat)
public protocol Animatable: class {

  /**
     `AnimationType` enum
  */
  var animationType: AnimationType { get set }

  /**
   Auto run flag, if `true` it will automatically start animation when `layoutSubviews`. Default should be `true`
   */
  var autoRun: Bool { get set }

  /**
   Animation duration (in seconds)
   */
  var duration: TimeInterval { get set }

  /**
   Animation delay (in seconds, default value should be 0)
   */
  var delay: TimeInterval { get set }

  /**
   Spring animation damping (0 ~ 1, default value should be 0.7)
   */
  var damping: CGFloat { get set }

  /**
   Spring animation velocity (default value should be 0.7)
   */
  var velocity: CGFloat { get set }

  /**
   Animation force (default value should be 1)
   */
  var force: CGFloat { get set }

}

public extension Animatable where Self: UIView {
  public func configureAnimatableProperties() {
    // Apply default values
    if duration.isNaN {
      duration = 0.7
    }
    if delay.isNaN {
      delay = 0
    }
    if damping.isNaN {
      damping = 0.7
    }
    if velocity.isNaN {
      velocity = 0.7
    }
    if force.isNaN {
      force = 1
    }
  }

  @discardableResult
  public func animate(_ animation: AnimationType,
                      duration: TimeInterval? = nil,
                      damping: CGFloat? = nil,
                      velocity: CGFloat? = nil,
                      force: CGFloat? = nil) -> AnimationPromise<Self> {
    return AnimationPromise(view: self).delay(delay).then(animation, duration: duration, damping: damping, velocity: velocity, force: force)
  }

  public func delay(_ delay: TimeInterval) -> AnimationPromise<Self> {
    let promise = AnimationPromise(view: self)
    return promise.delay(delay)

  }

  internal func doAnimation(_ animation: AnimationType? = nil, configuration: AnimationConfiguration, promise: AnimationPromise<Self>) {
    let completion = {
      promise.animationCompleted()
    }
    switch animation ?? animationType {
    case let .slide(way, direction):
      slide(way, direction: direction, configuration: configuration, completion: completion)
    case let .squeeze(way, direction):
      squeeze(way, direction: direction, configuration: configuration, completion: completion)
    case let .squeezeFade(way, direction):
      squeezeFade(way, direction: direction, configuration: configuration, completion: completion)
    case let .slideFade(way, direction):
      slideFade(way, direction: direction, configuration: configuration, completion: completion)
    case let .fade(way):
      fade(way, configuration: configuration, completion: completion)
    case let .zoom(way):
      zoom(way, configuration: configuration, completion: completion)
    case let .zoomInvert(way):
      zoom(way, invert: true, configuration: configuration, completion: completion)
    case let .shake(repeatCount):
      shake(repeatCount: repeatCount, configuration: configuration, completion: completion)
    case let .pop(repeatCount):
      pop(repeatCount: repeatCount, configuration: configuration, completion: completion)
    case let .squash(repeatCount):
      squash(repeatCount: repeatCount, configuration: configuration, completion: completion)
    case let .flip(axis):
      flip(axis: axis, configuration: configuration, completion: completion)
    case let .morph(repeatCount):
      morph(repeatCount: repeatCount, configuration: configuration, completion: completion)
    case let .flash(repeatCount):
      flash(repeatCount: repeatCount, configuration: configuration, completion: completion)
    case let .wobble(repeatCount):
      wobble(repeatCount: repeatCount, configuration: configuration, completion: completion)
    case let .swing(repeatCount):
      swing(repeatCount: repeatCount, configuration: configuration, completion: completion)
    case let .rotate(direction, repeatCount):
      rotate(direction: direction, repeatCount: repeatCount, configuration: configuration, completion: completion)
    case let .moveBy(x, y):
      moveBy(x: x, y: y, configuration: configuration, completion: completion)
    case let .moveTo(x, y):
      moveTo(x: x, y: y, configuration: configuration, completion: completion)
    case .none:
      break
    }
  }

  /**
   `autoRunAnimation` method, should be called in layoutSubviews() method
   */
  func autoRunAnimation() {
    if autoRun {
      autoRun = false
      animate(animationType)
    }
  }
}

fileprivate extension Animatable where Self: UIView {

  // MARK: - Animation methods
  func slide(_ way: AnimationType.Way, direction: AnimationType.Direction,
             configuration: AnimationConfiguration,
             completion: AnimatableCompletion? = nil) {
    let values = computeValues(way: way, direction: direction, configuration: configuration, shouldScale: false)
    switch way {
    case .in:

      animateIn(animationValues: values, alpha: 1, configuration: configuration, completion: completion)
    case .out:
      animateOut(animationValues: values, alpha: 1, configuration: configuration, completion: completion)
    }
  }

  func squeeze(_ way: AnimationType.Way, direction: AnimationType.Direction,
               configuration: AnimationConfiguration,
               completion: AnimatableCompletion? = nil) {
    let values = computeValues(way: way, direction: direction, configuration: configuration, shouldScale: true)
    switch way {
    case .in:
      animateIn(animationValues: values, alpha: 1, configuration: configuration, completion: completion)
    case .out:
      animateOut(animationValues: values, alpha: 1, configuration: configuration, completion: completion)
    }
  }

  func rotate(direction: AnimationType.RotationDirection, repeatCount: Int,
              configuration: AnimationConfiguration,
              completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: "transform.rotation")
      animation.fromValue = direction == .cw ? 0 : CGFloat.pi * 2
      animation.toValue = direction == .cw  ? CGFloat.pi * 2 : 0
      animation.duration = configuration.duration
      animation.repeatCount = Float(repeatCount)
      animation.autoreverses = false
      animation.beginTime = CACurrentMediaTime() + configuration.delay
      self.layer.add(animation, forKey: "rotate")
      }, completion: completion)

  }

  func moveTo(x: Double, y: Double, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    if x.isNaN && y.isNaN {
      return
    }
    // Get the absolute position
    let absolutePosition = convert(frame.origin, to: nil)
    var xOffsetToMove: CGFloat
    if x.isNaN {
      xOffsetToMove = 0
    } else {
      xOffsetToMove = CGFloat(x) - absolutePosition.x
    }

    var yOffsetToMove: CGFloat
    if y.isNaN {
      yOffsetToMove = 0
    } else {
      yOffsetToMove = CGFloat(y) - absolutePosition.y
    }
    animateBy(x: xOffsetToMove, y: yOffsetToMove, configuration: configuration, completion: completion)
  }

  func slideFade(_ way: AnimationType.Way, direction: AnimationType.Direction,
                 configuration: AnimationConfiguration,
                 completion: AnimatableCompletion? = nil) {
    let values = computeValues(way: way, direction: direction, configuration: configuration, shouldScale: false)
    switch way {
    case .in:
      alpha = 0
      animateIn(animationValues: values, alpha: 1, configuration: configuration, completion: completion)
    case .out:
      animateOut(animationValues: values, alpha: 0, configuration: configuration, completion: completion)
    }
  }

  func fade(_ way: AnimationType.FadeWay, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    switch way {
    case .outIn:
      fadeOutIn(configuration: configuration, completion: completion)
    case .inOut:
      fadeInOut(configuration: configuration, completion: completion)
    case .in:
      alpha = 0
      animateIn(animationValues: AnimationValues(x: 0, y: 0, scaleX: 1, scaleY: 1), alpha: 1, configuration: configuration, completion: completion)
    case .out:
      alpha = 1
      animateOut(animationValues: AnimationValues(x: 0, y: 0, scaleX: 1, scaleY: 1), alpha: 0, configuration: configuration, completion: completion)
    }
  }

    func squeezeFade(_ way: AnimationType.Way, direction: AnimationType.Direction,
                     configuration: AnimationConfiguration,
                     completion: AnimatableCompletion? = nil) {
    let values = computeValues(way: way, direction: direction, configuration: configuration, shouldScale: true)
    switch way {
    case .in:
      alpha = 0
      animateIn(animationValues: values, alpha: 1, configuration: configuration, completion: completion)
    case .out:
      animateOut(animationValues: values, alpha: 0, configuration: configuration, completion: completion)
    }
  }

  func zoom(_ way: AnimationType.Way, invert: Bool = false, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    let toAlpha: CGFloat

    switch way {
    case .in where invert:
      let scale = configuration.force
      alpha = 0
      toAlpha = 1
      transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
      animateIn(animationValues: AnimationValues(x: 0, y: 0, scaleX: scale / 2, scaleY: scale / 2),
                alpha: toAlpha,
                configuration: configuration,
                completion: completion)
    case .in:
      let scale = 2 * configuration.force
      alpha = 0
      toAlpha = 1
      animateIn(animationValues: AnimationValues(x: 0, y: 0, scaleX: scale, scaleY: scale),
                alpha: toAlpha,
                configuration: configuration,
                completion: completion)
    case .out:
      let scale = (invert ? 0.1 :  2) * configuration.force
      alpha = 1
      toAlpha = 0
      animateOut(animationValues: AnimationValues(x: 0, y: 0, scaleX: scale, scaleY: scale),
                 alpha: toAlpha,
                 configuration: configuration,
                 completion: completion)
    }
  }

  func flip(axis: AnimationType.Axis, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    let scaleX: CGFloat
    let scaleY: CGFloat
    switch axis {
    case .x:
      scaleX = 1
      scaleY = -1
    case .y:
      scaleX = -1
      scaleY = 1
    }
    animateIn(animationValues: AnimationValues(x: 0, y: 0, scaleX: scaleX, scaleY: scaleY),
              alpha: 1,
              configuration: configuration,
              completion: completion)
  }

  func shake(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CAKeyframeAnimation(keyPath: "position.x")
      animation.values = [0, 30 * configuration.force, -30 * configuration.force, 30 * configuration.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = configuration.duration
      animation.isAdditive = true
      animation.repeatCount = Float(repeatCount)
      animation.beginTime = CACurrentMediaTime() + configuration.delay
      self.layer.add(animation, forKey: "shake")
    }, completion: completion)
  }

  func pop(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CAKeyframeAnimation(keyPath: "transform.scale")
      animation.values = [0, 0.2 * configuration.force, -0.2 * configuration.force, 0.2 * configuration.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = configuration.duration
      animation.isAdditive = true
      animation.repeatCount = Float(repeatCount)
      animation.beginTime = CACurrentMediaTime() + configuration.delay
      self.layer.add(animation, forKey: "pop")
    }, completion: completion)
  }

  func squash(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let squashX = CAKeyframeAnimation(keyPath: "transform.scale.x")
      squashX.values = [1, 1.5 * configuration.force, 0.5, 1.5 * configuration.force, 1]
      squashX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squashX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

      let squashY = CAKeyframeAnimation(keyPath: "transform.scale.y")
      squashY.values = [1, 0.5, 1, 0.5, 1]
      squashY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squashY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [squashX, squashY]
      animationGroup.duration = configuration.duration
      animationGroup.repeatCount = Float(repeatCount)
      animationGroup.beginTime = CACurrentMediaTime() + configuration.delay
      self.layer.add(animationGroup, forKey: "squash")
    }, completion: completion)
  }

  func morph(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let morphX = CAKeyframeAnimation(keyPath: "transform.scale.x")
      morphX.values = [1, 1.3 * configuration.force, 0.7, 1.3 * configuration.force, 1]
      morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

      let morphY = CAKeyframeAnimation(keyPath: "transform.scale.y")
      morphY.values = [1, 0.7, 1.3 * configuration.force, 0.7, 1]
      morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [morphX, morphY]
      animationGroup.duration = configuration.duration
      animationGroup.repeatCount = Float(repeatCount)
      animationGroup.beginTime = CACurrentMediaTime() + configuration.delay
      self.layer.add(animationGroup, forKey: "morph")
    }, completion: completion)
  }

  func squeeze(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let squeezeX = CAKeyframeAnimation(keyPath: "transform.scale.x")
      squeezeX.values = [1, 1.5 * configuration.force, 0.5, 1.5 * configuration.force, 1]
      squeezeX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

      let squeezeY = CAKeyframeAnimation(keyPath: "transform.scale.y")
      squeezeY.values = [1, 0.5, 1, 0.5, 1]
      squeezeY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [squeezeX, squeezeY]
      animationGroup.duration = configuration.duration
      animationGroup.repeatCount = Float(repeatCount)
      animationGroup.beginTime = CACurrentMediaTime() + configuration.delay
      self.layer.add(animationGroup, forKey: "squeeze")
    }, completion: completion)
  }

  func flash(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.fromValue = 1
      animation.toValue = 0
      animation.duration = configuration.duration
      animation.repeatCount = Float(repeatCount) * 2.0
      animation.autoreverses = true
      animation.beginTime = CACurrentMediaTime() + configuration.delay
      self.layer.add(animation, forKey: "flash")
    }, completion: completion)
  }

  func wobble(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let rotation = CAKeyframeAnimation(keyPath: "transform.rotation")
      rotation.values = [0, 0.3 * configuration.force, -0.3 * configuration.force, 0.3 * configuration.force, 0]
      rotation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      rotation.isAdditive = true

      let positionX = CAKeyframeAnimation(keyPath: "position.x")
      positionX.values = [0, 30 * configuration.force, -30 * configuration.force, 30 * configuration.force, 0]
      positionX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      positionX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      positionX.isAdditive = true

      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [rotation, positionX]
      animationGroup.duration = configuration.duration
      animationGroup.beginTime = CACurrentMediaTime() + configuration.delay
      animationGroup.repeatCount = Float(repeatCount)
      self.layer.add(animationGroup, forKey: "wobble")
    }, completion: completion)
  }

  func swing(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
      animation.values = [0, 0.3 * configuration.force, -0.3 * configuration.force, 0.3 * configuration.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.duration = configuration.duration
      animation.isAdditive = true
      animation.repeatCount = Float(repeatCount)
      animation.beginTime = CACurrentMediaTime() + configuration.delay
      self.layer.add(animation, forKey: "swing")
    }, completion: completion)
  }

  // swiftlint:disable variable_name_min_length
  func moveBy(x: Double, y: Double, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    if x.isNaN && y.isNaN {
      return
    }

    let xOffsetToMove = x.isNaN ? 0: CGFloat(x)
    let yOffsetToMove = y.isNaN ? 0: CGFloat(y)
    animateBy(x: xOffsetToMove, y: yOffsetToMove, configuration: configuration, completion: completion)
  }

// swiftlint:enable variable_name_min_length
  func computeValues(way: AnimationType.Way, direction: AnimationType.Direction,
                     configuration: AnimationConfiguration,
                     shouldScale: Bool) -> AnimationValues {
    let scale = 3 * configuration.force
    var scaleX: CGFloat = 1
    var scaleY: CGFloat = 1

    var frame: CGRect
    if let window = window {
      frame = window.convert(self.frame, to: window)
    } else {
      frame = self.frame
    }

    var x: CGFloat = 0
    var y: CGFloat = 0
    switch (way, direction) {
    case (.in, .left), (.out, .right):
      x = screenSize.width - frame.minX
    case (.in, .right), (.out, .left):
      x = -frame.maxX
    case (.in, .up), (.out, .down):
      y = screenSize.height - frame.minY
    case (.in, .down), (.out, .up):
      y = -frame.maxY
    }

    x *= configuration.force
    y *= configuration.force
    if shouldScale && direction.isVertical() {
      scaleY = scale
    } else if shouldScale {
      scaleX = scale
    }

    return (x: x, y: y, scaleX: scaleX, scaleY: scaleY)
  }

  func fadeOutIn(configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.fromValue = 1
      animation.toValue = 0
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = configuration.duration
      animation.beginTime = CACurrentMediaTime() + configuration.delay
      animation.autoreverses = true
      self.layer.add(animation, forKey: "fade")
      }, completion: completion)
  }

  func fadeInOut(configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.fromValue = 0
      animation.toValue = 1
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = configuration.duration
      animation.beginTime = CACurrentMediaTime() + configuration.delay
      animation.autoreverses = true
      animation.isRemovedOnCompletion = false
      self.layer.add(animation, forKey: "fade")
      },
      completion: {
        self.alpha = 0
        completion?()
      }
    )
  }

  // swiftlint:disable variable_name_min_length
  func animateBy(x: CGFloat, y: CGFloat, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: x, y: y)
    UIView.animate(withDuration: configuration.duration,
                   delay: configuration.delay,
                   usingSpringWithDamping: configuration.damping,
                   initialSpringVelocity: configuration.velocity,
                   options: [],
      animations: {
        self.transform = translate
      },
      completion: { completed in
        if completed {
          completion?()
        }
      }
    )
  }

  func animateIn(animationValues: AnimationValues, alpha: CGFloat, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: animationValues.x, y: animationValues.y)
    let scale = CGAffineTransform(scaleX: animationValues.scaleX, y: animationValues.scaleY)
    let translateAndScale = translate.concatenating(scale)
    transform = translateAndScale

    UIView.animate(withDuration: configuration.duration,
                   delay: configuration.delay,
                   usingSpringWithDamping: configuration.damping,
                   initialSpringVelocity: configuration.velocity,
                   options: [],
      animations: {
        self.transform = CGAffineTransform.identity
        self.alpha = alpha
      },
      completion: { completed in
        if completed {
          completion?()
        }
    })
  }

  func animateOut(animationValues: AnimationValues, alpha: CGFloat, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: animationValues.x, y: animationValues.y)
    let scale = CGAffineTransform(scaleX: animationValues.scaleX, y: animationValues.scaleY)
    let translateAndScale = translate.concatenating(scale)

    UIView.animate(withDuration: configuration.duration,
                   delay: configuration.delay,
                   usingSpringWithDamping: configuration.damping,
                   initialSpringVelocity: configuration.velocity,
                   options: [],
      animations: {
        self.transform = translateAndScale
        self.alpha = alpha
      },
      completion: { completed in
        if completed {
          completion?()
        }
      }
    )
  }

  var screenSize: CGSize {
    return window?.screen.bounds.size ?? .zero
  }
}
// swiftlint:enable variable_name_min_length

public extension Animatable where Self: UIBarItem {
  // TODO: animations for `UIBarItem`
  public func animate(completion: AnimatableCompletion? = nil) {
  }
}
