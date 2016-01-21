//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public typealias AnimatableCompletion = () -> Void
public typealias AnimatableExecution = () -> Void

public protocol Animatable: class {
#if TARGET_INTERFACE_BUILDER
  /**
    String value of predefined Animation Type, all supported types are in `AnimationType` enum
  */
  var animationType: String? { get set }
#else
  /**
   Predefined Animation Type, all supported types are in `AnimationType` enum
   */
  var animationType: AnimationType? { get set }
  var animationTypeRaw: String? { get set }
#endif
  
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
   Animation farece (default value should be 1)
   */
  var force: CGFloat  { get set }
  
  /**
   Repeat count for Shake, Pop, Morph, Squeeze, Flash, Wobble and Swing animations
   */
  var repeatCount: Float { get set }
}

public extension Animatable where Self: UIView {
  public func configAnimatableProperites() {
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
  
  public func animate(completion: AnimatableCompletion? = nil) {
    #if TARGET_INTERFACE_BUILDER
      guard let unwrappedAnimationTypeString = animationType, animationType = AnimationType(rawValue: unwrappedAnimationTypeString) else {
        return
      }
    #else
      guard let animationType = animationType else {
        return
      }
    #endif
    
    switch(animationType) {
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
  public func slideInLeft(completion: AnimatableCompletion? = nil) {
    let x = -300 * force
    animateInWithX(x, completion: completion);
  }

  public func slideInRight(completion: AnimatableCompletion? = nil) {
    let x = 300 * force
    animateInWithX(x, completion: completion);
  }

  public func slideInDown(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    animateInWithY(y, completion: completion)
  }

  public func slideInUp(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    animateInWithY(y, completion: completion)
  }
  
  public func slideOutLeft(completion: AnimatableCompletion? = nil) {
    let x = -300 * force
    animateOutWithX(x, alpha: 1, completion: completion);
  }

  public func slideOutRight(completion: AnimatableCompletion? = nil) {
    let x = 300 * force
    animateOutWithX(x, alpha: 1, completion: completion);
  }
  
  public func slideOutDown(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    animateOutWithY(y, alpha: 1, completion: completion);
  }
  
  public func slideOutUp(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    animateOutWithY(y, alpha: 1, completion: completion);
  }
  
  public func squeezeInLeft(completion: AnimatableCompletion? = nil) {
    let x = -300 * force
    let scaleX = 3 * force
    animateInWithX(x, scaleX: scaleX, completion: completion)
  }
  
  public func squeezeInRight(completion: AnimatableCompletion? = nil) {
    let x = 300 * force
    let scaleX = 3 * force
    animateInWithX(x, scaleX: scaleX, completion: completion)
  }
  
  public func squeezeInDown(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    let scaleY = 3 * force
    animateInWithY(y, scaleY: scaleY, completion: completion)
  }
  
  public func squeezeInUp(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    let scaleY = 3 * force
    animateInWithY(y, scaleY: scaleY, completion: completion)
  }
  
  public func squeezeOutLeft(completion: AnimatableCompletion? = nil) {
    let x = -300 * force
    let scaleX = 3 * force
    animateOutWithX(x, scaleX: scaleX, alpha: 1, completion: completion)
  }
  
  public func squeezeOutRight(completion: AnimatableCompletion? = nil) {
    let x = 300 * force
    let scaleX = 3 * force
    animateOutWithX(x, scaleX: scaleX, alpha: 1, completion: completion)
  }
  
  public func squeezeOutDown(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    let scaleY = 3 * force
    animateOutWithY(y, scaleY: scaleY, alpha: 1, completion: completion)
  }
  
  public func squeezeOutUp(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    let scaleY = 3 * force
    animateOutWithY(y, scaleY: scaleY, alpha: 1, completion: completion)
  }
  
  public func fadeInLeft(completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInLeft(completion)
  }
  
  public func fadeInRight(completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInRight(completion)
  }
  
  public func fadeInDown(completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInDown(completion)
  }
  
  public func fadeInUp(completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInUp(completion)
  }
  
  public func fadeOutLeft(completion: AnimatableCompletion? = nil) {
    let x = -300 * force
    animateOutWithX(x, alpha: 0, completion: completion)
  }
  
  public func fadeOutRight(completion: AnimatableCompletion? = nil) {
    let x = 300 * force
    animateOutWithX(x, alpha: 0, completion: completion)
  }
  
  public func fadeOutDown(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    animateOutWithY(y, alpha: 0, completion: completion)
  }
  
  public func fadeOutUp(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    animateOutWithY(y, alpha: 0, completion: completion)
  }

  public func squeezeFadeInLeft(completion: AnimatableCompletion? = nil) {
    alpha = 0
    squeezeInLeft(completion)
  }
  
  public func squeezeFadeInRight(completion: AnimatableCompletion? = nil) {
    alpha = 0
    squeezeInRight(completion)
  }
  
  public func squeezeFadeInDown(completion: AnimatableCompletion? = nil) {
    alpha = 0
    squeezeInDown(completion)
  }
  
  public func squeezeFadeInUp(completion: AnimatableCompletion? = nil) {
    alpha = 0
    squeezeInUp(completion)
  }

  public func squeezeFadeOutLeft(completion: AnimatableCompletion? = nil) {
    let x = -300 * force
    let scaleX = 3 * force
    animateOutWithX(x, scaleX: scaleX, alpha: 0, completion: completion)
  }

  public func squeezeFadeOutRight(completion: AnimatableCompletion? = nil) {
    let x = 300 * force
    let scaleX = 3 * force
    animateOutWithX(x, scaleX: scaleX, alpha: 0, completion: completion)
  }
  
  public func squeezeFadeOutDown(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    let scaleY = 3 * force
    animateOutWithY(y, scaleY: scaleY, alpha: 0, completion: completion)
  }
  
  public func squeezeFadeOutUp(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    let scaleY = 3 * force
    animateOutWithY(y, scaleY: scaleY, alpha: 0, completion: completion)
  }

  public func fadeIn(completion: AnimatableCompletion? = nil) {
    alpha = 0
    animateWithAlpha(1, completion: completion)
  }

  public func fadeOut(completion: AnimatableCompletion? = nil) {
    alpha = 1
    animateWithAlpha(0, completion: completion)
  }
  
  public func fadeOutIn(completion: AnimatableCompletion? = nil) {
    animateLayer({
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.fromValue = 1
      animation.toValue = 0
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(self.duration)
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      animation.autoreverses = true
      self.layer.addAnimation(animation, forKey: "fade")
      }, completion: completion)
  }
  
  public func fadeInOut(completion: AnimatableCompletion? = nil) {
    animateLayer({
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.fromValue = 0
      animation.toValue = 1
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(self.duration)
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      animation.autoreverses = true
      animation.removedOnCompletion = false
      self.layer.addAnimation(animation, forKey: "fade")
      }, completion: {
      self.alpha = 0
      completion?()
    })
  }
  
  public func zoomIn(completion: AnimatableCompletion? = nil) {
    let scaleX = 2 * force
    let scaleY = 2 * force
    alpha = 0
    let toAlpha: CGFloat = 1
    animateInWithScaleX(scaleX, scaleY: scaleY, alpha: toAlpha, completion: completion)
  }
  
  public func zoomOut(completion: AnimatableCompletion? = nil) {
    let scaleX = 2 * force
    let scaleY = 2 * force
    alpha = 1
    let toAlpha: CGFloat = 0
    animateOutWithScaleX(scaleX, scaleY: scaleY, alpha: toAlpha, completion: completion)
  }
  
  public func shake(completion: AnimatableCompletion? = nil) {
    animateLayer({
      let animation = CAKeyframeAnimation(keyPath: "position.x")
      animation.values = [0, 30 * self.force, -30 * self.force, 30 * self.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(self.duration)
      animation.additive = true
      animation.repeatCount = self.repeatCount
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.addAnimation(animation, forKey: "shake")
      }, completion: completion)
  }
  
  public func pop(completion: AnimatableCompletion? = nil) {
    animateLayer({
      let animation = CAKeyframeAnimation(keyPath: "transform.scale")
      animation.values = [0, 0.2 * self.force, -0.2 * self.force, 0.2 * self.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(self.duration)
      animation.additive = true
      animation.repeatCount = self.repeatCount
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.addAnimation(animation, forKey: "pop")
      }, completion: completion)
  }
  
  public func morph(completion: AnimatableCompletion? = nil) {
    animateLayer({
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
      self.layer.addAnimation(animationGroup, forKey: "morph")
      }, completion: completion)
  }

  public func squeeze(completion: AnimatableCompletion? = nil) {
    animateLayer({
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
      self.layer.addAnimation(animationGroup, forKey: "squeeze")
      }, completion: completion)
  }
  
  public func flipX(completion: AnimatableCompletion? = nil) {
    let scaleX: CGFloat = 1
    let scaleY: CGFloat = -1
    animateInWithScaleX(scaleX, scaleY: scaleY, alpha: 1, completion: completion)
  }
  
  public func flipY(completion: AnimatableCompletion? = nil) {
    let scaleX: CGFloat = -1
    let scaleY: CGFloat = 1
    animateInWithScaleX(scaleX, scaleY: scaleY, alpha: 1, completion: completion)
  }
  
  public func flash(completion: AnimatableCompletion? = nil) {
    animateLayer({
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.fromValue = 1
      animation.toValue = 0
      animation.duration = CFTimeInterval(self.duration)
      animation.repeatCount = self.repeatCount * 2.0
      animation.autoreverses = true
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.addAnimation(animation, forKey: "flash")
      }, completion: completion)
  }
  
  public func wobble(completion: AnimatableCompletion? = nil) {
    animateLayer({
      let rotation = CAKeyframeAnimation(keyPath: "transform.rotation")
      rotation.values = [0, 0.3 * self.force, -0.3 * self.force, 0.3 * self.force, 0]
      rotation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      rotation.additive = true
      
      let positionX = CAKeyframeAnimation(keyPath: "position.x")
      positionX.values = [0, 30 * self.force, -30 * self.force, 30 * self.force, 0]
      positionX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      positionX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      positionX.additive = true
      
      let animationGroup = CAAnimationGroup()
      animationGroup.animations = [rotation, positionX]
      animationGroup.duration = CFTimeInterval(self.duration)
      animationGroup.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      animationGroup.repeatCount = self.repeatCount
      self.layer.addAnimation(animationGroup, forKey: "wobble")
      }, completion: completion)
  }
  
  public func swing(completion: AnimatableCompletion? = nil) {
    animateLayer({
      let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
      animation.values = [0, 0.3 * self.force, -0.3 * self.force, 0.3 * self.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.duration = CFTimeInterval(self.duration)
      animation.additive = true
      animation.repeatCount = self.repeatCount
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      self.layer.addAnimation(animation, forKey: "swing")
      }, completion: completion)
  }

  // MARK: - Private
  private func animateLayer(animation: AnimatableExecution, completion: AnimatableCompletion? = nil) {
    CATransaction.begin()
    CATransaction.setCompletionBlock{ completion?() }
    animation()
    CATransaction.commit()
  }
  
  private func animateInWithX(x: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(x, 0, 1, 1, 1, completion);
  }
  
  private func animateOutWithX(x: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(x, 0, 1, 1, alpha, completion);
  }

  private func animateInWithY(y: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(0, y, 1, 1, 1, completion);
  }
  
  private func animateOutWithY(y: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(0, y, 1, 1, alpha, completion);
  }

  private func animateInWithX(x: CGFloat, scaleX: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(x, 0, scaleX, 1, 1, completion);
  }
  
  private func animateOutWithX(x: CGFloat, scaleX: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(x, 0, scaleX, 1, alpha, completion);
  }
  
  private func animateInWithY(y: CGFloat, scaleY: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(0, y, 1, scaleY, 1, completion);
  }
  
  private func animateOutWithY(y: CGFloat, scaleY: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(0, y, 1, scaleY, alpha, completion);
  }
  
  private func animateInWithScaleX(scaleX: CGFloat, scaleY: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(0, 0, scaleX, scaleY, alpha, completion)
  }
  
  private func animateOutWithScaleX(scaleX: CGFloat, scaleY: CGFloat, alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(0, 0, scaleX, scaleY, alpha, completion)
  }
  
  private func animateWithAlpha(alpha: CGFloat, completion: AnimatableCompletion? = nil) {
    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
      self.alpha = alpha
      }, completion: { (completed) -> Void in
        completion?()
    })
  }

  private func animateIn(x: CGFloat, _ y: CGFloat, _ scaleX: CGFloat, _ scaleY: CGFloat, _ alpha: CGFloat, _ completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransformMakeTranslation(x, y)
    let scale = CGAffineTransformMakeScale(scaleX, scaleY)
    let translateAndScale = CGAffineTransformConcat(translate, scale)
    transform = translateAndScale

    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
      self.transform = CGAffineTransformIdentity
      self.alpha = alpha
      }, completion: { (completed) -> Void in
        completion?()
    })
  }

  private func animateOut(x: CGFloat, _ y: CGFloat, _ scaleX: CGFloat, _ scaleY: CGFloat, _ alpha: CGFloat, _ completion: AnimatableCompletion? = nil) {
    let translate = CGAffineTransformMakeTranslation(x, y)
    let scale = CGAffineTransformMakeScale(scaleX, scaleY)
    let translateAndScale = CGAffineTransformConcat(translate, scale)

    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
      self.transform = translateAndScale
      self.alpha = alpha
      }, completion: { (completed) -> Void in
        completion?()
      })
  }
}

public extension Animatable where Self: UIBarItem {
  // TODO: animations for `UIBarItem`
  public func animate(completion: AnimatableCompletion? = nil) {
  }
}
