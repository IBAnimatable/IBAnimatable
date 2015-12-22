//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public typealias AnimatableCompletion = () -> Void
public typealias AnimatableExecution = () -> Void

public protocol Animatable: class {
  
  /**
    String value of `AnimationType` enum
  */
  var animationType: String { get set }
  
  /**
   Auto run flag, if `true` it will automatically start animation when `layoutSubviews`. Default should be `true`
   */
  var autoRun: Bool { get set }
  
  /**
   Specify whether only run once for `autoRun`
   */
  var autoRunOnce: Bool { get set }
  
  /**
   Animation duration (seconds)
   */
  var duration: Double { get set }
  
  /**
   Animation delay (seconds, default value should be 0.7)
   */
  var delay: Double { get set }
  
  /**
   Animation farece (default value should be 1)
   */
  var force: CGFloat  { get set }
  
  /**
   Spring animation damping (default value should be 0.7)
   */
  var damping: CGFloat { get set }
  
  /**
   Spring animation velocity (default value should be 0.7)
   */
  var velocity: CGFloat { get set }
  
  /**
   Repeat count for some animations like shake
   */
  var repeatCount: Float { get set }
}

public extension Animatable where Self: UIView {
  public func animate(completion: AnimatableCompletion? = nil) {
    guard let animationType = AnimationType(rawValue: animationType) else {
      return
    }
    
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
    animateInWithX(x);
  }

  public func slideInDown(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    animateInWithY(y)
  }

  public func slideInUp(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    animateInWithY(y)
  }
  
  public func slideOutLeft(completion: AnimatableCompletion? = nil) {
    let x = -300 * force
    animateOutWithX(x, alpha: 1);
  }

  public func slideOutRight(completion: AnimatableCompletion? = nil) {
    let x = 300 * force
    animateOutWithX(x, alpha: 1);
  }
  
  public func slideOutDown(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    animateOutWithY(y, alpha: 1);
  }
  
  public func slideOutUp(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    animateOutWithY(y, alpha: 1);
  }
  
  public func squeezeInLeft(completion: AnimatableCompletion? = nil) {
    let x = -300 * force
    let scaleX = 3 * force
    animateInWithX(x, scaleX: scaleX)
  }
  
  public func squeezeInRight(completion: AnimatableCompletion? = nil) {
    let x = 300 * force
    let scaleX = 3 * force
    animateInWithX(x, scaleX: scaleX)
  }
  
  public func squeezeInDown(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    let scaleY = 3 * force
    animateInWithY(y, scaleY: scaleY)
  }
  
  public func squeezeInUp(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    let scaleY = 3 * force
    animateInWithY(y, scaleY: scaleY)
  }
  
  public func squeezeOutLeft(completion: AnimatableCompletion? = nil) {
    let x = -300 * force
    let scaleX = 3 * force
    animateOutWithX(x, scaleX: scaleX)
  }
  
  public func squeezeOutRight(completion: AnimatableCompletion? = nil) {
    let x = 300 * force
    let scaleX = 3 * force
    animateOutWithX(x, scaleX: scaleX)
  }
  
  public func squeezeOutDown(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    let scaleY = 3 * force
    animateOutWithY(y, scaleY: scaleY)
  }
  
  public func squeezeOutUp(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    let scaleY = 3 * force
    animateOutWithY(y, scaleY: scaleY)
  }
  
  public func fadeInLeft(completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInLeft()
  }
  
  public func fadeInRight(completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInRight()
  }
  
  public func fadeInDown(completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInDown()
  }
  
  public func fadeInUp(completion: AnimatableCompletion? = nil) {
    alpha = 0
    slideInUp()
  }
  
  public func fadeOutLeft(completion: AnimatableCompletion? = nil) {
    let x = -300 * force
    animateOutWithX(x, alpha: 0);
  }
  
  public func fadeOutRight(completion: AnimatableCompletion? = nil) {
    let x = 300 * force
    animateOutWithX(x, alpha: 0);
  }
  
  public func fadeOutDown(completion: AnimatableCompletion? = nil) {
    let y = 300 * force
    animateOutWithY(y, alpha: 0);
  }
  
  public func fadeOutUp(completion: AnimatableCompletion? = nil) {
    let y = -300 * force
    animateOutWithY(y, alpha: 0);
  }

  public func fadeIn(completion: AnimatableCompletion? = nil) {
    alpha = 0
    animateWithAlpha(1)
  }

  public func fadeOut(completion: AnimatableCompletion? = nil) {
    alpha = 1
    animateWithAlpha(0)
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
    animateInWithScaleX(scaleX, scaleY: scaleY, alpha: toAlpha)
  }
  
  public func zoomOut(completion: AnimatableCompletion? = nil) {
    let scaleX = 2 * force
    let scaleY = 2 * force
    alpha = 1
    let toAlpha: CGFloat = 0
    animateOutWithScaleX(scaleX, scaleY: scaleY, alpha: toAlpha)
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
      morphX.duration = CFTimeInterval(self.duration)
      morphX.repeatCount = self.repeatCount
      morphX.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      
      let morphY = CAKeyframeAnimation(keyPath: "transform.scale.y")
      morphY.values = [1, 0.7, 1.3 * self.force, 0.7, 1]
      morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      morphY.duration = CFTimeInterval(self.duration)
      morphY.repeatCount = self.repeatCount
      morphY.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      
      self.layer.addAnimation(morphX, forKey: "morphX")
      self.layer.addAnimation(morphY, forKey: "morphY")
      }, completion: completion)
  }

  public func squeeze(completion: AnimatableCompletion? = nil) {
    animateLayer({
      let squeezeX = CAKeyframeAnimation(keyPath: "transform.scale.x")
      squeezeX.values = [1, 1.5 * self.force, 0.5, 1.5 * self.force, 1]
      squeezeX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      squeezeX.duration = CFTimeInterval(self.duration)
      squeezeX.repeatCount = self.repeatCount
      squeezeX.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      
      let squeezeY = CAKeyframeAnimation(keyPath: "transform.scale.y")
      squeezeY.values = [1, 0.5, 1, 0.5, 1]
      squeezeY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      squeezeY.duration = CFTimeInterval(self.duration)
      squeezeY.repeatCount = self.repeatCount
      squeezeY.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      
      self.layer.addAnimation(squeezeX, forKey: "squeezeX")
      self.layer.addAnimation(squeezeY, forKey: "squeezeY")
      }, completion: completion)
  }
  
  public func flipX(completion: AnimatableCompletion? = nil) {
    let scaleX: CGFloat = 1
    let scaleY: CGFloat = -1
    animateInWithScaleX(scaleX, scaleY: scaleY, alpha: 1)
  }
  
  public func flipY(completion: AnimatableCompletion? = nil) {
    let scaleX: CGFloat = -1
    let scaleY: CGFloat = 1
    animateInWithScaleX(scaleX, scaleY: scaleY, alpha: 1)
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
      rotation.duration = CFTimeInterval(self.duration)
      rotation.additive = true
      rotation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      
      let positionX = CAKeyframeAnimation(keyPath: "position.x")
      positionX.values = [0, 30 * self.force, -30 * self.force, 30 * self.force, 0]
      positionX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      positionX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      positionX.duration = CFTimeInterval(self.duration)
      positionX.additive = true
      positionX.repeatCount = self.repeatCount
      positionX.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay)
      
      self.layer.addAnimation(rotation, forKey: "rotation")
      self.layer.addAnimation(positionX, forKey: "positionX")
      }, completion: completion)
  }
  
  public func swing(completion: AnimatableCompletion? = nil) {
    animateLayer({
      let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
      animation.values = [0, 0.3 * self.force, -0.3 * self.force, 0.3 * self.force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.duration = CFTimeInterval(self.duration)
      animation.additive = true
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
  
  private func animateOutWithX(x: CGFloat, scaleX: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(x, 0, scaleX, 1, 1, completion);
  }
  
  private func animateInWithY(y: CGFloat, scaleY: CGFloat, completion: AnimatableCompletion? = nil) {
    animateIn(0, y, 1, scaleY, 1, completion);
  }
  
  private func animateOutWithY(y: CGFloat, scaleY: CGFloat, completion: AnimatableCompletion? = nil) {
    animateOut(0, y, 1, scaleY, 1, completion);
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
