//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

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
  var duration: Double { get set }
  
  /**
   Animation delay (in seconds, default value should be 0)
   */
  var delay: Double { get set }
  
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
   Repeat count for Shake, Pop, Morph, Squeeze, Flash, Wobble and Swing animations
   */
  var repeatCount: Float { get set }

}

public extension Animatable where Self: UIView {
  public func configAnimatableProperties() {
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
    if repeatCount.isNaN {
      repeatCount = 1
    }
  }
  
  public func animate(_ animation: AnimationType? = nil, completion: AnimatableCompletion? = nil) {
    switch animation ?? animationType {
    case let .slide(way, direction):
      slide(way, direction: direction, completion: completion)
    case let .squeeze(way, direction):
      squeeze(way, direction: direction, completion: completion)
    case let .squeezeFade(way, direction):
      squeezeFade(way, direction: direction, completion: completion)
    case let .slideFade(way, direction):
      slideFade(way, direction: direction, completion: completion)
    case let .fade(way):
      fade(way, completion: completion)
    case let .zoom(way):
      zoom(way, completion: completion)
    case let .zoomInvert(way):
      zoom(way, invert: true, completion: completion)
    case .shake:
      shake(completion)
    case .pop:
      pop(completion)
    case let .flip( axis):
      flip(axis, completion: completion)
    case .morph:
      morph(completion)
    case .flash:
      flash(completion)
    case .wobble:
      wobble(completion)
    case .swing:
      swing(completion)
    case let .rotate(direction):
      rotate(direction, completion: completion)
    case let .moveBy(x, y):
      moveBy(x, y: y, completion: completion)
    case let .moveTo(x, y):
      moveTo(x, y: y, completion: completion)
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
      animate()
    }
  }
  
  // MARK: - Animation methods
  fileprivate func computeValues(_ way: AnimationType.Way, direction: AnimationType.Direction, shouldScale: Bool) -> AnimationValues {
    let yDistance = screenSize.height * force
    let xDistance = screenSize.width * force
    let scale = 3 * force
    var scaleX: CGFloat = 1
    var scaleY: CGFloat = 1
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    switch direction {
    case .left:
      x = -xDistance
    case .right:
      x = xDistance
    case .down:
      y = -yDistance
    case .up:
      y = yDistance
    }
    if shouldScale && direction.isVertical() {
      scaleY = scale
    } else if shouldScale {
      scaleX = scale
    }
    switch way {
    case .in:
      return (x: x, y: y, scaleX: scaleX, scaleY: scaleY)
    case .out where direction.isVertical():
      return (x: x, y: -y, scaleX: scaleX, scaleY: scaleY)
    case .out:
      return (x: x, y: y, scaleX: scaleX, scaleY: scaleY)
    }
    
  }
  
  public func slide(_ way: AnimationType.Way, direction: AnimationType.Direction, completion: AnimatableCompletion? = nil) {

    let values = computeValues(way, direction: direction, shouldScale: false)
    switch way {
    case .in:
      animateIn(values.x, values.y, values.scaleX, values.scaleY, 1, completion)
    case .out:
      animateOut(values.x, values.y, values.scaleX, values.scaleY, 1, completion)
    }
  }
  
  
  public func squeeze( _ way: AnimationType.Way, direction: AnimationType.Direction, completion: AnimatableCompletion? = nil) {
  
    let values = computeValues(way, direction: direction, shouldScale: true)
    switch way {
    case .in:
      animateIn(values.x, values.y, values.scaleX, values.scaleY, 1, completion)
    case .out:
      animateOut(values.x, values.y, values.scaleX, values.scaleY, 1, completion)
    }
  }
  
  public func rotate(_ direction: AnimationType.RotationDirection, completion: AnimatableCompletion? = nil) {
  
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: "transform.rotation")
      animation.fromValue = direction == .cw ? 0 : CGFloat.pi * 2
      animation.toValue = direction == .cw  ? CGFloat.pi * 2 : 0
      animation.duration = CFTimeInterval(self.duration)
      animation.repeatCount = self.repeatCount
      animation.autoreverses = false
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.add(animation, forKey: "rotate")
      }, completion: completion)

  }
  
  public func moveTo(_ x: Double, y: Double, completion: AnimatableCompletion? = nil) {
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
      animateBy(xOffsetToMove, y: yOffsetToMove, completion: completion)
  }
  
  public func slideFade( _ way: AnimationType.Way, direction: AnimationType.Direction, completion: AnimatableCompletion? = nil) {
    
    let values = computeValues(way, direction: direction, shouldScale: false)
    switch way {
    case .in:
      alpha = 0
      animateIn(values.x, values.y, values.scaleX, values.scaleY, 1, completion)
    case .out:
      animateOut(values.x, values.y, values.scaleX, values.scaleY, 0, completion)
    }
  }
  public func fade(_ way: AnimationType.FadeWay, completion: AnimatableCompletion? = nil) {
    switch way {
    case .outIn:
      fadeOutIn(completion)
    case .inOut:
      fadeInOut(completion)
    case .in:
      alpha = 0
      animateIn(0, 0, 1, 1, 1, completion)
    case .out:
      alpha = 1
      animateOut(0, 0, 1, 1, 0, completion)
    }
  }
  
  public func squeezeFade(_ way: AnimationType.Way, direction: AnimationType.Direction, completion: AnimatableCompletion? = nil) {
    
    let values = computeValues(way, direction: direction, shouldScale: true)
    switch way {
    case .in:
      alpha = 0
      animateIn(values.x, values.y, values.scaleX, values.scaleY, 1, completion)
    case .out:
      animateOut(values.x, values.y, values.scaleX, values.scaleY, 0, completion)
    }
  }
  
  public func zoom(_ way: AnimationType.Way, invert: Bool = false, completion: AnimatableCompletion? = nil) {
    let toAlpha: CGFloat

    switch way {
    case .in where invert:
      let scale = force
      alpha = 0
      toAlpha = 1
      transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
      animateIn(0, 0, scale / 2, scale / 2, toAlpha, completion)
    case .in:
      let scale = 2 * force
      alpha = 0
      toAlpha = 1
      animateIn(0, 0, scale, scale, toAlpha, completion)
    case .out:
      let scale = (invert ? 0.1 :  2) * force
      alpha = 1
      toAlpha = 0
      animateOut(0, 0, scale, scale, toAlpha, completion)
    }
    
  }
  
  public func flip(_ axis: AnimationType.Axis, completion: AnimatableCompletion? = nil) {
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
    animateIn(0, 0, scaleX, scaleY, 1, completion)
  
  }
  public func shake(_ completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CAKeyframeAnimation(keyPath: "position.x")
      animation.values = [0, 30 * self.force, -30 * self.force, 30 * self.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(self.duration)
      animation.isAdditive = true
      animation.repeatCount = self.repeatCount
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.add(animation, forKey: "shake")
    }, completion: completion)
  }
  
  public func pop(_ completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CAKeyframeAnimation(keyPath: "transform.scale")
      animation.values = [0, 0.2 * self.force, -0.2 * self.force, 0.2 * self.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(self.duration)
      animation.isAdditive = true
      animation.repeatCount = self.repeatCount
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.add(animation, forKey: "pop")
    }, completion: completion)
  }
  
  public func morph(_ completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let morphX = CAKeyframeAnimation(keyPath: "transform.scale.x")
      morphX.values = [1, 1.3 * self.force, 0.7, 1.3 * self.force, 1]
      morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
     
      let morphY = CAKeyframeAnimation(keyPath: "transform.scale.y")
      morphY.values = [1, 0.7, 1.3 * self.force, 0.7, 1]
      morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      
      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [morphX, morphY]
      animationGroup.duration = CFTimeInterval(self.duration)
      animationGroup.repeatCount = self.repeatCount
      animationGroup.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.add(animationGroup, forKey: "morph")
    }, completion: completion)
  }

  public func squeeze(_ completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let squeezeX = CAKeyframeAnimation(keyPath: "transform.scale.x")
      squeezeX.values = [1, 1.5 * self.force, 0.5, 1.5 * self.force, 1]
      squeezeX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      
      let squeezeY = CAKeyframeAnimation(keyPath: "transform.scale.y")
      squeezeY.values = [1, 0.5, 1, 0.5, 1]
      squeezeY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      
      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [squeezeX, squeezeY]
      animationGroup.duration = CFTimeInterval(self.duration)
      animationGroup.repeatCount = self.repeatCount
      animationGroup.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.add(animationGroup, forKey: "squeeze")
    }, completion: completion)
  }
  
  public func flash(_ completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.fromValue = 1
      animation.toValue = 0
      animation.duration = CFTimeInterval(self.duration)
      animation.repeatCount = self.repeatCount * 2.0
      animation.autoreverses = true
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.add(animation, forKey: "flash")
    }, completion: completion)
  }
  
  public func wobble(_ completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let rotation = CAKeyframeAnimation(keyPath: "transform.rotation")
      rotation.values = [0, 0.3 * self.force, -0.3 * self.force, 0.3 * self.force, 0]
      rotation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      rotation.isAdditive = true
      
      let positionX = CAKeyframeAnimation(keyPath: "position.x")
      positionX.values = [0, 30 * self.force, -30 * self.force, 30 * self.force, 0]
      positionX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      positionX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      positionX.isAdditive = true
      
      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [rotation, positionX]
      animationGroup.duration = CFTimeInterval(self.duration)
      animationGroup.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      animationGroup.repeatCount = self.repeatCount
      self.layer.add(animationGroup, forKey: "wobble")
    }, completion: completion)
  }
  
  public func swing(_ completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
      animation.values = [0, 0.3 * self.force, -0.3 * self.force, 0.3 * self.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.duration = CFTimeInterval(self.duration)
      animation.isAdditive = true
      animation.repeatCount = self.repeatCount
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.add(animation, forKey: "swing")
    }, completion: completion)
  }

  public func moveBy(_ x: Double, y: Double, completion: AnimatableCompletion? = nil) {
    if x.isNaN && y.isNaN {
      return
    }
    
    let xOffsetToMove = x.isNaN ? 0: CGFloat(x)
    let yOffsetToMove = y.isNaN ? 0: CGFloat(y)
    animateBy(xOffsetToMove, y: yOffsetToMove, completion: completion)
  }
  
  // MARK: - Private
  fileprivate func fadeOutIn(_ completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.fromValue = 1
      animation.toValue = 0
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(self.duration)
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      animation.autoreverses = true
      self.layer.add(animation, forKey: "fade")
      }, completion: completion)
  }
  
  fileprivate func fadeInOut(_ completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.fromValue = 0
      animation.toValue = 1
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(self.duration)
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      animation.autoreverses = true
      animation.isRemovedOnCompletion = false
      self.layer.add(animation, forKey: "fade")
      },
                    completion: {
                      self.alpha = 0
                      completion?()
    })
  }

  fileprivate func animateBy(_ x: CGFloat, y: CGFloat, completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: x, y: y)
    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [],
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
 
  
  fileprivate func animateIn(_ x: CGFloat, _ y: CGFloat, _ scaleX: CGFloat, _ scaleY: CGFloat, _ alpha: CGFloat, _ completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: x, y: y)
    let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
    let translateAndScale = translate.concatenating(scale)
    transform = translateAndScale

    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [],
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

  fileprivate func animateOut(_ x: CGFloat, _ y: CGFloat, _ scaleX: CGFloat, _ scaleY: CGFloat, _ alpha: CGFloat, _ completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: x, y: y)
    let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
    let translateAndScale = translate.concatenating(scale)

    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [],
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
  
  // MARK: Private helper
  fileprivate var screenSize: CGSize {
    return self.window?.screen.bounds.size ?? CGSize.zero
  }
}

public extension Animatable where Self: UIBarItem {
  // TODO: animations for `UIBarItem`
  public func animate(_ completion: AnimatableCompletion? = nil) {
  }
}
