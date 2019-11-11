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

  /**
   Animation function as a timing curve. (default value should be none)
   */
  var timingFunction: TimingFunctionType { get set }

}

public extension Animatable {
  func configureAnimatableProperties() {
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
}

public extension Animatable where Self: UIView {
  @discardableResult
  func animate(_ animation: AnimationType,
               duration: TimeInterval? = nil,
               damping: CGFloat? = nil,
               velocity: CGFloat? = nil,
               force: CGFloat? = nil) -> AnimationPromise<Self> {
    return AnimationPromise(view: self).delay(delay).then(animation, duration: duration, damping: damping, velocity: velocity, force: force)
  }

  func delay(_ delay: TimeInterval) -> AnimationPromise<Self> {
    let promise = AnimationPromise(view: self)
    return promise.delay(delay)

  }

  internal func doAnimation(_ animation: AnimationType? = nil, configuration: AnimationConfiguration, promise: AnimationPromise<Self>) {
    let completion = {
      promise.animationCompleted()
    }
    doAnimation(animation ?? self.animationType, configuration: configuration, completion: completion)
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

fileprivate extension UIView {

  func doAnimation(_ animation: AnimationType, configuration: AnimationConfiguration, completion: @escaping () -> Void) {
    switch animation {
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
    case let .scale(fromX, fromY, toX, toY):
      scale(fromX: fromX, fromY: fromY, toX: toX, toY: toY, configuration: configuration, completion: completion)
    case let .spin(repeatCount):
      spin(repeatCount: repeatCount, configuration: configuration, completion: completion)
    case let .compound(animations, run):
      let animations = animations.filter {
        if case .none = $0 {
          return false
        }
        return true
      }
      guard !animations.isEmpty else {
        completion()
        return
      }
      switch run {
      case .sequential:
        let launch = animations.reversed().reduce(completion) { result, animation in {
            self.doAnimation(animation, configuration: configuration, completion: result)
          }
        }
        launch()
      case .parallel:
        var finalized = 0
        let finalCompletion: () -> Void = {
          finalized += 1
          if finalized == animations.count {
            completion()
          }
        }
        for animation in animations {
          self.doAnimation(animation, configuration: configuration, completion: finalCompletion)
        }
      }
    case .none:
      break
    }
  }

  // MARK: - Animation methods
  func slide(_ way: AnimationType.Way,
             direction: AnimationType.Direction,
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

  func squeeze(_ way: AnimationType.Way,
               direction: AnimationType.Direction,
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

  func rotate(direction: AnimationType.RotationDirection,
              repeatCount: Int,
              configuration: AnimationConfiguration,
              completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: .rotation)
      animation.fromValue = direction == .cw ? 0 : CGFloat.pi * 2
      animation.toValue = direction == .cw  ? CGFloat.pi * 2 : 0
      animation.duration = configuration.duration
      animation.repeatCount = Float(repeatCount)
      animation.autoreverses = false
      animation.beginTime = self.layer.currentMediaTime + configuration.delay
      self.layer.add(animation, forKey: "rotate")
      }, completion: completion)

  }

  func moveTo(x: Double, y: Double, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    if x.isNaN && y.isNaN {
      return
    }
    if case .none = configuration.timingFunction {
      // Get the absolute position
      let absolutePosition = frame.origin
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
    } else {
      let position = center
      var xToMove: CGFloat
      if x.isNaN {
        xToMove = position.x
      } else {
        xToMove = CGFloat(x) + frame.width / 2
      }

      var yToMove: CGFloat
      if y.isNaN {
        yToMove = position.y
      } else {
        yToMove = CGFloat(y) + frame.height / 2
      }

      let path = UIBezierPath()
      path.move(to: position)
      path.addLine(to: CGPoint(x: xToMove, y: yToMove))

      animatePosition(path: path, configuration: configuration, completion: completion)
    }
  }

  func slideFade(_ way: AnimationType.Way,
                 direction: AnimationType.Direction,
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

  func squeezeFade(_ way: AnimationType.Way,
                   direction: AnimationType.Direction,
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
      let animation = CAKeyframeAnimation(keyPath: .positionX)
      animation.values = [0, 30 * configuration.force, -30 * configuration.force, 30 * configuration.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.timingFunctionType = configuration.timingFunction ?? .easeInOut
      animation.duration = configuration.duration
      animation.isAdditive = true
      animation.repeatCount = Float(repeatCount)
      animation.beginTime = self.layer.currentMediaTime + configuration.delay
      self.layer.add(animation, forKey: "shake")
    }, completion: completion)
  }

  func pop(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CAKeyframeAnimation(keyPath: .scale)
      animation.values = [0, 0.2 * configuration.force, -0.2 * configuration.force, 0.2 * configuration.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.timingFunctionType = configuration.timingFunction ?? .easeInOut
      animation.duration = configuration.duration
      animation.isAdditive = true
      animation.repeatCount = Float(repeatCount)
      animation.beginTime = self.layer.currentMediaTime + configuration.delay
      self.layer.add(animation, forKey: "pop")
    }, completion: completion)
  }

  func squash(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let squashX = CAKeyframeAnimation(keyPath: .scaleX)
      squashX.values = [1, 1.5 * configuration.force, 0.5, 1.5 * configuration.force, 1]
      squashX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squashX.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let squashY = CAKeyframeAnimation(keyPath: .scaleY)
      squashY.values = [1, 0.5, 1, 0.5, 1]
      squashY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squashY.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [squashX, squashY]
      animationGroup.duration = configuration.duration
      animationGroup.repeatCount = Float(repeatCount)
      animationGroup.beginTime = self.layer.currentMediaTime + configuration.delay
      self.layer.add(animationGroup, forKey: "squash")
    }, completion: completion)
  }

  func morph(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let morphX = CAKeyframeAnimation(keyPath: .scaleX)
      morphX.values = [1, 1.3 * configuration.force, 0.7, 1.3 * configuration.force, 1]
      morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphX.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let morphY = CAKeyframeAnimation(keyPath: .scaleY)
      morphY.values = [1, 0.7, 1.3 * configuration.force, 0.7, 1]
      morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphY.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [morphX, morphY]
      animationGroup.duration = configuration.duration
      animationGroup.repeatCount = Float(repeatCount)
      animationGroup.beginTime = self.layer.currentMediaTime + configuration.delay
      self.layer.add(animationGroup, forKey: "morph")
    }, completion: completion)
  }

  func squeeze(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let squeezeX = CAKeyframeAnimation(keyPath: .scaleX)
      squeezeX.values = [1, 1.5 * configuration.force, 0.5, 1.5 * configuration.force, 1]
      squeezeX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeX.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let squeezeY = CAKeyframeAnimation(keyPath: .scaleY)
      squeezeY.values = [1, 0.5, 1, 0.5, 1]
      squeezeY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeY.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [squeezeX, squeezeY]
      animationGroup.duration = configuration.duration
      animationGroup.repeatCount = Float(repeatCount)
      animationGroup.beginTime = self.layer.currentMediaTime + configuration.delay
      self.layer.add(animationGroup, forKey: "squeeze")
    }, completion: completion)
  }

  func flash(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: .opacity)
      animation.fromValue = 1
      animation.toValue = 0
      animation.duration = configuration.duration
      animation.repeatCount = Float(repeatCount) * 2.0
      animation.autoreverses = true
      animation.beginTime = self.layer.currentMediaTime + configuration.delay
      self.layer.add(animation, forKey: "flash")
    }, completion: completion)
  }

  func wobble(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let rotation = CAKeyframeAnimation(keyPath: .rotation)
      rotation.values = [0, 0.3 * configuration.force, -0.3 * configuration.force, 0.3 * configuration.force, 0]
      rotation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      rotation.isAdditive = true

      let positionX = CAKeyframeAnimation(keyPath: .positionX)
      positionX.values = [0, 30 * configuration.force, -30 * configuration.force, 30 * configuration.force, 0]
      positionX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      positionX.timingFunctionType = configuration.timingFunction ?? .easeInOut
      positionX.isAdditive = true

      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [rotation, positionX]
      animationGroup.duration = configuration.duration
      animationGroup.beginTime = self.layer.currentMediaTime + configuration.delay
      animationGroup.repeatCount = Float(repeatCount)
      self.layer.add(animationGroup, forKey: "wobble")
    }, completion: completion)
  }

  func swing(repeatCount: Int, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CAKeyframeAnimation(keyPath: .rotation)
      animation.values = [0, 0.3 * configuration.force, -0.3 * configuration.force, 0.3 * configuration.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.duration = configuration.duration
      animation.isAdditive = true
      animation.repeatCount = Float(repeatCount)
      animation.beginTime = self.layer.currentMediaTime + configuration.delay
      self.layer.add(animation, forKey: "swing")
    }, completion: completion)
  }

  func moveBy(x: Double, y: Double, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    if x.isNaN && y.isNaN {
      return
    }

    if case .none = configuration.timingFunction {
      // spring animation
      let xOffsetToMove = x.isNaN ? 0: CGFloat(x)
      let yOffsetToMove = y.isNaN ? 0: CGFloat(y)

      animateBy(x: xOffsetToMove, y: yOffsetToMove, configuration: configuration, completion: completion)
    } else {
      let position = self.center
      var xToMove: CGFloat
      if x.isNaN {
        xToMove = position.x
      } else {
        xToMove = position.x + CGFloat(x)
      }

      var yToMove: CGFloat
      if y.isNaN {
        yToMove = position.y
      } else {
        yToMove = position.y + CGFloat(y)
      }

      let path = UIBezierPath()
      path.move(to: position)
      path.addLine(to: CGPoint(x: xToMove, y: yToMove))

      animatePosition(path: path, configuration: configuration, completion: completion)
    }
  }

  func scale(fromX: Double, fromY: Double, toX: Double, toY: Double, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    if fromX.isNaN || fromY.isNaN || toX.isNaN || toY.isNaN {
      return
    }
    if case .none = configuration.timingFunction {
      springScale(fromX: fromX, fromY: fromY, toX: toX, toY: toY, configuration: configuration, completion: completion)
    } else {
      layerScale(fromX: fromX, fromY: fromY, toX: toX, toY: toY, configuration: configuration, completion: completion)
    }
  }

  private func springScale(fromX: Double,
                           fromY: Double,
                           toX: Double,
                           toY: Double,
                           configuration: AnimationConfiguration,
                           completion: AnimatableCompletion? = nil) {
    transform = CGAffineTransform(scaleX: CGFloat(fromX), y: CGFloat(fromY))
    UIView.animate(with: configuration, animations: {
      self.transform = CGAffineTransform(scaleX: CGFloat(toX), y: CGFloat(toY))
    }, completion: { completed in
      if completed {
        completion?()
      }
    })
  }

  private func layerScale(fromX: Double,
                          fromY: Double,
                          toX: Double,
                          toY: Double,
                          configuration: AnimationConfiguration,
                          completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let scaleX = CAKeyframeAnimation(keyPath: .scaleX)
      scaleX.values = [fromX, toX]
      scaleX.keyTimes = [0, 1]
      scaleX.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let scaleY = CAKeyframeAnimation(keyPath: .scaleY)
      scaleY.values = [fromY, toY]
      scaleY.keyTimes = [0, 1]
      scaleY.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [scaleX, scaleY]
      animationGroup.duration = configuration.duration
      animationGroup.beginTime = self.layer.currentMediaTime + configuration.delay
      self.layer.add(animationGroup, forKey: "scale")
    }, completion: completion)
  }

  func computeValues(way: AnimationType.Way,
                     direction: AnimationType.Direction,
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

  func spin(repeatCount: Int,
            configuration: AnimationConfiguration,
            completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let rotationX = CABasicAnimation(keyPath: .rotationX)
      rotationX.toValue = CGFloat.pi * 2
      rotationX.fromValue = 0
      rotationX.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let rotationY = CABasicAnimation(keyPath: .rotationY)
      rotationY.toValue = CGFloat.pi * 2
      rotationY.fromValue = 0
      rotationY.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let rotationZ = CABasicAnimation(keyPath: .rotationZ)
      rotationZ.toValue = CGFloat.pi * 2
      rotationZ.fromValue = 0
      rotationZ.timingFunctionType = configuration.timingFunction ?? .easeInOut

      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [rotationX, rotationY, rotationZ]
      animationGroup.duration = configuration.duration
      animationGroup.repeatCount = Float(repeatCount)
      animationGroup.beginTime = CACurrentMediaTime() + configuration.delay
      self.layer.add(animationGroup, forKey: "rotation")
    }, completion: completion)
  }

  func fadeOutIn(configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: .opacity)
      animation.fromValue = 1
      animation.toValue = 0
      animation.timingFunctionType = configuration.timingFunction ?? .easeInOut
      animation.duration = configuration.duration
      animation.beginTime = self.layer.currentMediaTime + configuration.delay
      animation.autoreverses = true
      self.layer.add(animation, forKey: "fade")
      }, completion: completion)
  }

  func fadeInOut(configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: .opacity)
      animation.fromValue = 0
      animation.toValue = 1
      animation.timingFunctionType = configuration.timingFunction ?? .easeInOut
      animation.duration = configuration.duration
      animation.beginTime = self.layer.currentMediaTime + configuration.delay
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

  func animateBy(x: CGFloat, y: CGFloat, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: x, y: y)
    UIView.animate(with: configuration, animations: {
      self.transform = translate
    }, completion: { completed in
      if completed {
        completion?()
      }
    })
  }

  func animatePosition(path: UIBezierPath, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CAKeyframeAnimation(keyPath: .position)
      animation.timingFunctionType = configuration.timingFunction ?? .easeInOut
      animation.duration = configuration.duration
      animation.beginTime = self.layer.currentMediaTime + configuration.delay
      animation.path = path.cgPath
      self.layer.add(animation, forKey: "animate position")
    }, completion: completion)
  }

  func animateIn(animationValues: AnimationValues, alpha: CGFloat, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: animationValues.x, y: animationValues.y)
    let scale = CGAffineTransform(scaleX: animationValues.scaleX, y: animationValues.scaleY)
    let translateAndScale = translate.concatenating(scale)
    transform = translateAndScale

    UIView.animate(with: configuration, animations: {
      self.transform = .identity
      self.alpha = alpha
    }, completion: { completed in
      if completed {
        completion?()
      }
    })
  }

  func animateOut(animationValues: AnimationValues, alpha: CGFloat, configuration: AnimationConfiguration, completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: animationValues.x, y: animationValues.y)
    let scale = CGAffineTransform(scaleX: animationValues.scaleX, y: animationValues.scaleY)
    let translateAndScale = translate.concatenating(scale)

    UIView.animate(with: configuration, animations: {
      self.transform = translateAndScale
      self.alpha = alpha
    }, completion: { completed in
      if completed {
        completion?()
      }
    })
  }

  var screenSize: CGSize {
    return window?.screen.bounds.size ?? .zero
  }
}

// Animations for `UIBarItem`
public extension Animatable where Self: UIBarItem {

  func animate(_ animation: AnimationType? = nil,
               duration: TimeInterval? = nil,
               damping: CGFloat? = nil,
               velocity: CGFloat? = nil,
               force: CGFloat? = nil,
               view: UIView,
               completion: AnimatableCompletion? = nil) {

    let configuration = AnimationConfiguration(damping: damping ?? self.damping,
                                               velocity: velocity ?? self.velocity,
                                               duration: duration ?? self.duration,
                                               delay: 0,
                                               force: force ?? self.force,
                                               timingFunction: timingFunction ?? self.timingFunction)
    view.doAnimation(animation ?? self.animationType, configuration: configuration) {
      completion?()
    }
  }
}

public extension AnimationType {

  /// This animation use damping and velocity parameters.
  var isSpring: Bool {
    switch self {
    case .moveBy, .moveTo, .scale:
      return true
    case .squeeze, .squeezeFade, .slide, .slideFade, .zoom, .zoomInvert:
      return true
    case .fade(way: .in), .fade(way: .out):
      return true
    case .rotate, .shake, .flip, .pop, .squash, .morph, .swing, .wobble, .flash, .spin:
      return false
    case .fade(way: .inOut), .fade(way: .outIn):
      return false
    case .compound(let animations, _):
      return animations.contains { $0.isSpring }
    case .none:
      return false
    }
  }

  /// This animation use timing function parameter.
  var isCubic: Bool {
    switch self {
    case .moveBy, .moveTo, .scale:
      return true
    case .rotate, .shake, .flip, .pop, .squash, .morph, .swing, .wobble, .flash, .spin:
      return true
    case .fade(.inOut), .fade(.outIn):
      return true
    case .squeeze, .squeezeFade, .slide, .slideFade, .zoom, .zoomInvert:
      return false
    case .fade(way: .in), .fade(way: .out):
      return false
    case .compound(let animations, _):
      return animations.contains { $0.isCubic }
    case .none:
      return false
    }
  }
}

/// Enumeration for Core Animation key path.
enum AnimationKeyPath: String {
  // Positions
  case position = "position"
  case positionX = "position.x"
  case positionY = "position.y"
  // Transforms
  case transform  = "transform"
  case rotation  = "transform.rotation"
  case rotationX = "transform.rotation.x"
  case rotationY = "transform.rotation.y"
  case rotationZ = "transform.rotation.z"
  case scale  = "transform.scale"
  case scaleX = "transform.scale.x"
  case scaleY = "transform.scale.y"
  case scaleZ = "transform.scale.z"
  case translation  = "transform.translation"
  case translationX = "transform.translation.x"
  case translationY = "transform.translation.y"
  case translationZ = "transform.translation.z"
  // Stroke
  case strokeEnd = "strokeEnd"
  case strokeStart = "strokeStart"
  // Other properties
  case opacity = "opacity"
  case path = "path"
  case lineWidth = "lineWidth"
}

extension CABasicAnimation {
  convenience init(keyPath: AnimationKeyPath) {
    self.init(keyPath: keyPath.rawValue)
  }
}

extension CAKeyframeAnimation {
  convenience init(keyPath: AnimationKeyPath) {
    self.init(keyPath: keyPath.rawValue)
  }
}

extension UIView {
  /// Animate view using `AnimationConfiguration`.
  class func animate(with configuration: AnimationConfiguration, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
    if configuration.timingFunction.isCurveOption {
      UIView.animate(withDuration: configuration.duration,
                     delay: configuration.delay,
                     options: configuration.options,
                     animations: animations,
                     completion: completion)
    } else {
      UIView.animate(withDuration: configuration.duration,
                     delay: configuration.delay,
                     usingSpringWithDamping: configuration.damping,
                     initialSpringVelocity: configuration.velocity,
                     options: configuration.options,
                     animations: animations,
                     completion: completion)
    }
  }
}
