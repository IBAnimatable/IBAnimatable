//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol Animatable: class {
  
  /**
    String value of `AnimationType` enum
  */
  var animationType: String? { get set }
  
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

  /**
   x position for MoveTo animation
   */
  var x: CGFloat { get set }
  
  /**
   y position for MoveTo animation
   */
  var y: CGFloat { get set }
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
  
  public func animate(_ completion: AnimatableCompletion? = nil) {
    guard let unwrappedAnimationTypeString = animationType, animationType = AnimationType(rawValue: unwrappedAnimationTypeString) else {
      return
    }
    
    switch animationType {
    case .SlideInLeft:
      slideInLeft(completion)
    case .SlideInRight:
      slideInRight(completion)
    case .SlideInDown:
      slideInDown(completion)
    case .SlideInUp:
      slideInUp(completion)
    case .SlideOutLeft:
      slideOutLeft(completion)
    case .SlideOutRight:
      slideOutRight(completion)
    case .SlideOutDown:
      slideOutDown(completion)
    case .SlideOutUp:
      slideOutUp(completion)
    case .SqueezeInLeft:
      squeezeInLeft(completion)
    case .SqueezeInRight:
      squeezeInRight(completion)
    case .SqueezeInDown:
      squeezeInDown(completion)
    case .SqueezeInUp:
      squeezeInUp(completion)
    case .SqueezeOutLeft:
      squeezeOutLeft(completion)
    case .SqueezeOutRight:
      squeezeOutRight(completion)
    case .SqueezeOutDown:
      squeezeOutDown(completion)
    case .SqueezeOutUp:
      squeezeOutUp(completion)
    case .FadeIn:
      fadeIn(completion)
    case .FadeOut:
      fadeOut(completion)
    case .FadeOutIn:
      fadeOutIn(completion)
    case .FadeInOut:
      fadeInOut(completion)
    case .FadeInLeft:
      fadeInLeft(completion)
    case .FadeInRight:
      fadeInRight(completion)
    case .FadeInDown:
      fadeInDown(completion)
    case .FadeInUp:
      fadeInUp(completion)
    case .FadeOutLeft:
      fadeOutLeft(completion)
    case .FadeOutRight:
      fadeOutRight(completion)
    case .FadeOutDown:
      fadeOutDown(completion)
    case .FadeOutUp:
      fadeOutUp(completion)
    case .SqueezeFadeInLeft:
      squeezeFadeInLeft()
    case .SqueezeFadeInRight:
      squeezeFadeInRight()
    case .SqueezeFadeInDown:
      squeezeFadeInDown()
    case .SqueezeFadeInUp:
      squeezeFadeInUp()
    case .SqueezeFadeOutLeft:
      squeezeFadeOutLeft()
    case .SqueezeFadeOutRight:
      squeezeFadeOutRight()
    case .SqueezeFadeOutDown:
      squeezeFadeOutDown()
    case .SqueezeFadeOutUp:
      squeezeFadeOutUp()
    case .ZoomIn:
      zoomIn(completion)
    case .ZoomOut:
      zoomOut(completion)
    case .Shake:
      shake(completion)
    case .Pop:
      pop(completion)
    case .FlipX:
      flipX(completion)
    case .FlipY:
      flipY(completion)
    case .Morph:
      morph(completion)
    case .Squeeze:
      squeeze(completion)
    case .Flash:
      flash(completion)
    case .Wobble:
      wobble(completion)
    case .Swing:
      swing(completion)
    case .Rotate:
      rotate(completion: completion)
    case .RotateCCW:
      rotate(false, completion: completion)
    case .MoveTo:
      moveTo(completion)
    case .MoveBy:
      moveBy(completion)
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
  
  public func slideInLeft(_ completion: AnimatableCompletion? = nil) {
    let x = -screenSize.width * force
    animateInWithX(x, completion: completion)
  }

  public func slideInRight(_ completion: AnimatableCompletion? = nil) {
    let x = screenSize.width * force
    animateInWithX(x, completion: completion)
  }

  public func slideInDown(_ completion: AnimatableCompletion? = nil) {
    let y = -screenSize.height * force
    animateInWithY(y, completion: completion)
  }

  public func slideInUp(_ completion: AnimatableCompletion? = nil) {
    let y = screenSize.height * force
    animateInWithY(y, completion: completion)
  }
  
  public func slideOutLeft(_ completion: AnimatableCompletion? = nil) {
    let x = -screenSize.width * force
    animateOutWithX(x, alpha: 1, completion: completion)
  }

  public func slideOutRight(_ completion: AnimatableCompletion? = nil) {
    let x = screenSize.width * force
    animateOutWithX(x, alpha: 1, completion: completion)
  }
  
  public func slideOutDown(_ completion: AnimatableCompletion? = nil) {
    let y = screenSize.height * force
    animateOutWithY(y, alpha: 1, completion: completion)
  }
  
  public func slideOutUp(_ completion: AnimatableCompletion? = nil) {
    let y = -screenSize.height * force
    animateOutWithY(y, alpha: 1, completion: completion)
  }
  
  public func squeezeInLeft(_ completion: AnimatableCompletion? = nil) {
    let x = -screenSize.width * force
    let scaleX = 3 * force
    animateInWithX(x, scaleX: scaleX, completion: completion)
  }
  
  public func squeezeInRight(_ completion: AnimatableCompletion? = nil) {
    let x = screenSize.width * force
    let scaleX = 3 * force
    animateInWithX(x, scaleX: scaleX, completion: completion)
  }
  
  public func squeezeInDown(_ completion: AnimatableCompletion? = nil) {
    let y = -screenSize.height * force
    let scaleY = 3 * force
    animateInWithY(y, scaleY: scaleY, completion: completion)
  }
  
  public func squeezeInUp(_ completion: AnimatableCompletion? = nil) {
    let y = screenSize.height * force
    let scaleY = 3 * force
    animateInWithY(y, scaleY: scaleY, completion: completion)
  }
  
  public func squeezeOutLeft(_ completion: AnimatableCompletion? = nil) {
    let x = -screenSize.width * force
    let scaleX = 3 * force
    animateOutWithX(x, scaleX: scaleX, alpha: 1, completion: completion)
  }
  
  public func squeezeOutRight(_ completion: AnimatableCompletion? = nil) {
    let x = screenSize.width * force
    let scaleX = 3 * force
    animateOutWithX(x, scaleX: scaleX, alpha: 1, completion: completion)
  }
  
  public func squeezeOutDown(_ completion: AnimatableCompletion? = nil) {
    let y = screenSize.height * force
    let scaleY = 3 * force
    animateOutWithY(y, scaleY: scaleY, alpha: 1, completion: completion)
  }
  
  public func squeezeOutUp(_ completion: AnimatableCompletion? = nil) {
    let y = -screenSize.height * force
    let scaleY = 3 * force
    animateOutWithY(y, scaleY: scaleY, alpha: 1, completion: completion)
  }
  
  public func fadeInLeft(_ completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInLeft(completion)
  }
  
  public func fadeInRight(_ completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInRight(completion)
  }
  
  public func fadeInDown(_ completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInDown(completion)
  }
  
  public func fadeInUp(_ completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInUp(completion)
  }
  
  public func fadeOutLeft(_ completion: AnimatableCompletion? = nil) {
    let x = -screenSize.width * force
    animateOutWithX(x, alpha: 0, completion: completion)
  }
  
  public func fadeOutRight(_ completion: AnimatableCompletion? = nil) {
    let x = screenSize.width * force
    animateOutWithX(x, alpha: 0, completion: completion)
  }
  
  public func fadeOutDown(_ completion: AnimatableCompletion? = nil) {
    let y = screenSize.height * force
    animateOutWithY(y, alpha: 0, completion: completion)
  }
  
  public func fadeOutUp(_ completion: AnimatableCompletion? = nil) {
    let y = -screenSize.height * force
    animateOutWithY(y, alpha: 0, completion: completion)
  }

  public func squeezeFadeInLeft(_ completion: AnimatableCompletion? = nil) {
    alpha = 0
    squeezeInLeft(completion)
  }
  
  public func squeezeFadeInRight(_ completion: AnimatableCompletion? = nil) {
    alpha = 0
    squeezeInRight(completion)
  }
  
  public func squeezeFadeInDown(_ completion: AnimatableCompletion? = nil) {
    alpha = 0
    squeezeInDown(completion)
  }
  
  public func squeezeFadeInUp(_ completion: AnimatableCompletion? = nil) {
    alpha = 0
    squeezeInUp(completion)
  }

  public func squeezeFadeOutLeft(_ completion: AnimatableCompletion? = nil) {
    let x = -screenSize.width * force
    let scaleX = 3 * force
    animateOutWithX(x, scaleX: scaleX, alpha: 0, completion: completion)
  }

  public func squeezeFadeOutRight(_ completion: AnimatableCompletion? = nil) {
    let x = screenSize.width * force
    let scaleX = 3 * force
    animateOutWithX(x, scaleX: scaleX, alpha: 0, completion: completion)
  }
  
  public func squeezeFadeOutDown(_ completion: AnimatableCompletion? = nil) {
    let y = screenSize.height * force
    let scaleY = 3 * force
    animateOutWithY(y, scaleY: scaleY, alpha: 0, completion: completion)
  }
  
  public func squeezeFadeOutUp(_ completion: AnimatableCompletion? = nil) {
    let y = -screenSize.height * force
    let scaleY = 3 * force
    animateOutWithY(y, scaleY: scaleY, alpha: 0, completion: completion)
  }

  public func fadeIn(_ completion: AnimatableCompletion? = nil) {
    alpha = 0
    animateWithAlpha(1, completion: completion)
  }

  public func fadeOut(_ completion: AnimatableCompletion? = nil) {
    alpha = 1
    animateWithAlpha(0, completion: completion)
  }
  
  public func fadeOutIn(_ completion: AnimatableCompletion? = nil) {
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
  
  public func fadeInOut(_ completion: AnimatableCompletion? = nil) {
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
  
  public func zoomIn(_ completion: AnimatableCompletion? = nil) {
    let scaleX = 2 * force
    let scaleY = 2 * force
    alpha = 0
    let toAlpha: CGFloat = 1
    animateInWithScaleX(scaleX, scaleY: scaleY, alpha: toAlpha, completion: completion)
  }
  
  public func zoomOut(_ completion: AnimatableCompletion? = nil) {
    let scaleX = 2 * force
    let scaleY = 2 * force
    alpha = 1
    let toAlpha: CGFloat = 0
    animateOutWithScaleX(scaleX, scaleY: scaleY, alpha: toAlpha, completion: completion)
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
  
  public func flipX(_ completion: AnimatableCompletion? = nil) {
    let scaleX: CGFloat = 1
    let scaleY: CGFloat = -1
    animateInWithScaleX(scaleX, scaleY: scaleY, alpha: 1, completion: completion)
  }
  
  public func flipY(_ completion: AnimatableCompletion? = nil) {
    let scaleX: CGFloat = -1
    let scaleY: CGFloat = 1
    animateInWithScaleX(scaleX, scaleY: scaleY, alpha: 1, completion: completion)
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

  public func rotate(_ clockwise: Bool = true, completion: AnimatableCompletion? = nil) {
    CALayer.animate({
      let animation = CABasicAnimation(keyPath: "transform.rotation")
      animation.fromValue = clockwise ? 0 : ((360 * M_PI) / 180)
      animation.toValue = clockwise ? ((360 * M_PI) / 180) : 0
      animation.duration = CFTimeInterval(self.duration)
      animation.repeatCount = self.repeatCount
      animation.autoreverses = false
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.add(animation, forKey: "rotate")
    }, completion: completion)
  }
  
  public func moveTo(_ completion: AnimatableCompletion? = nil) {
    if x.isNaN && y.isNaN {
      return
    }
    
    // Get the absolute position
    let absolutePosition = convert(frame.origin, to: nil)
    var xOffsetToMove: CGFloat
    if x.isNaN {
      xOffsetToMove = 0
    } else {
      xOffsetToMove = x - absolutePosition.x
    }
    
    var yOffsetToMove: CGFloat
    if y.isNaN {
      yOffsetToMove = 0
    } else {
      yOffsetToMove = y - absolutePosition.y
    }

    animateToWithX(xOffsetToMove, y: yOffsetToMove, completion: completion)
  }
  
  public func moveBy(_ completion: AnimatableCompletion? = nil) {
    if x.isNaN && y.isNaN {
      return
    }
    
    let xOffsetToMove = x.isNaN ? 0: x
    let yOffsetToMove = y.isNaN ? 0: y
    animateToWithX(xOffsetToMove, y: yOffsetToMove, completion: completion)
  }
  
  // MARK: - Private
  private func animateInWithX(_ x: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(x, 0, 1, 1, 1, completion)
  }
  
  private func animateOutWithX(_ x: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(x, 0, 1, 1, alpha, completion)
  }

  private func animateInWithY(_ y: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(0, y, 1, 1, 1, completion)
  }
  
  private func animateOutWithY(_ y: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(0, y, 1, 1, alpha, completion)
  }

  private func animateInWithX(_ x: CGFloat, scaleX: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(x, 0, scaleX, 1, 1, completion)
  }
  
  private func animateOutWithX(_ x: CGFloat, scaleX: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(x, 0, scaleX, 1, alpha, completion)
  }
  
  private func animateInWithY(_ y: CGFloat, scaleY: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(0, y, 1, scaleY, 1, completion)
  }
  
  private func animateOutWithY(_ y: CGFloat, scaleY: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(0, y, 1, scaleY, alpha, completion)
  }
  
  private func animateInWithScaleX(_ scaleX: CGFloat, scaleY: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(0, 0, scaleX, scaleY, alpha, completion)
  }
  
  private func animateOutWithScaleX(_ scaleX: CGFloat, scaleY: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(0, 0, scaleX, scaleY, alpha, completion)
  }
  
  private func animateWithAlpha(_ alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [],
      animations: {
        self.alpha = alpha
      },
      completion: { completed in
        if completed {
          completion?()
        }
      }
    )
  }

  private func animateToWithX(_ x: CGFloat, y: CGFloat, completion: AnimatableCompletion? = nil) {
    animateTo(x, y, completion)
  }

  private func animateTo(_ x: CGFloat, _ y: CGFloat, _ completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: x, y: y)
    UIView.animate(withDuration: duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [],
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

  private func animateIn(_ x: CGFloat, _ y: CGFloat, _ scaleX: CGFloat, _ scaleY: CGFloat, _ alpha: CGFloat, _ completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: x, y: y)
    let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
    let translateAndScale = translate.concat(scale)
    transform = translateAndScale

    UIView.animate(withDuration: duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [],
      animations: {
        self.transform = CGAffineTransform.identity
        self.alpha = alpha
      },
      completion: { completed in
        if completed {
          completion?()
        }
      }
    )
  }

  private func animateOut(_ x: CGFloat, _ y: CGFloat, _ scaleX: CGFloat, _ scaleY: CGFloat, _ alpha: CGFloat, _ completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransform(translationX: x, y: y)
    let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
    let translateAndScale = translate.concat(scale)

    UIView.animate(withDuration: duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [],
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
  private var screenSize: CGSize {
    return self.window?.screen.bounds.size ?? CGSize.zero
  }
}

public extension Animatable where Self: UIBarItem {
  // TODO: animations for `UIBarItem`
  public func animate(_ completion: AnimatableCompletion? = nil) {
  }
}
