//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol Animatable {
  
  /**
    String value of `AnimationType` enum
  */
  var animationType: String { get set }
  
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
  
  /**
   animate method, used in sub-protocol
  */
  func animate()
}

public extension Animatable where Self: UIView {
  public func animate() {
    guard let animationType = AnimationType(rawValue: animationType) else {
      return
    }
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    var scaleX: CGFloat = 1
    var scaleY: CGFloat = 1

    switch(animationType) {
    case .SlideInLeft:
      slideInLeft()
    case .SlideInRight:
      slideInRight()
    case .SlideInDown:
      slideInDown()
    case .SlideInUp:
      slideInUp()
    case .SqueezeInLeft:
      squeezeInLeft()
    case .SqueezeInRight:
      squeezeInRight()
    case .SqueezeInDown:
      squeezeInDown()
    case .SqueezeInUp:
      squeezeInUp()
    case .FadeIn:
      fadeIn()
    case .FadeOut:
      fadeOut()
    case .FadeOutIn:
      fadeOutIn()
    case .FadeInLeft:
      fadeInLeft()
    case .FadeInRight:
      fadeInRight()
    case .FadeInDown:
      fadeInDown()
    case .FadeInUp:
      fadeInUp()
    case .ZoomIn:
      zoomIn()
    case .ZoomOut:
      zoomOut()
    case .Shake:
      let animation = CAKeyframeAnimation(keyPath: "position.x")
      animation.values = [0, 30*force, -30*force, 30*force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(duration)
      animation.additive = true
      animation.repeatCount = repeatCount
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(animation, forKey: "shake")
      return
    case .Pop:
      let animation = CAKeyframeAnimation(keyPath: "transform.scale")
      animation.values = [0, 0.2*force, -0.2*force, 0.2*force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(duration)
      animation.additive = true
      animation.repeatCount = repeatCount
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(animation, forKey: "pop")
      return
    case .FlipX:
      scaleX = 1
      scaleY = -1
    case .FlipY:
      scaleX = -1
      scaleY = 1
    case .Morph:
      let morphX = CAKeyframeAnimation(keyPath: "transform.scale.x")
      morphX.values = [1, 1.3*force, 0.7, 1.3*force, 1]
      morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      morphX.duration = CFTimeInterval(duration)
      morphX.repeatCount = repeatCount
      morphX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(morphX, forKey: "morphX")
      
      let morphY = CAKeyframeAnimation(keyPath: "transform.scale.y")
      morphY.values = [1, 0.7, 1.3*force, 0.7, 1]
      morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      morphY.duration = CFTimeInterval(duration)
      morphY.repeatCount = repeatCount
      morphY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(morphY, forKey: "morphY")
      return
    case .Squeeze:
      let squeezeX = CAKeyframeAnimation(keyPath: "transform.scale.x")
      squeezeX.values = [1, 1.5*force, 0.5, 1.5*force, 1]
      squeezeX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      squeezeX.duration = CFTimeInterval(duration)
      squeezeX.repeatCount = repeatCount
      squeezeX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(squeezeX, forKey: "squeezeX")
      
      let squeezeY = CAKeyframeAnimation(keyPath: "transform.scale.y")
      squeezeY.values = [1, 0.5, 1, 0.5, 1]
      squeezeY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      squeezeY.duration = CFTimeInterval(duration)
      squeezeY.repeatCount = repeatCount
      squeezeY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(squeezeY, forKey: "squeezeY")
      return
    case .Flash:
      let animation = CABasicAnimation(keyPath: "opacity")
      animation.fromValue = 1
      animation.toValue = 0
      animation.duration = CFTimeInterval(duration)
      animation.repeatCount = repeatCount * 2.0
      animation.autoreverses = true
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(animation, forKey: "flash")
      return
    case .Wobble:
      let rotation = CAKeyframeAnimation(keyPath: "transform.rotation")
      rotation.values = [0, 0.3*force, -0.3*force, 0.3*force, 0]
      rotation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      rotation.duration = CFTimeInterval(duration)
      rotation.additive = true
      rotation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(rotation, forKey: "rotation")
      
      let positionX = CAKeyframeAnimation(keyPath: "position.x")
      positionX.values = [0, 30*force, -30*force, 30*force, 0]
      positionX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      positionX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      positionX.duration = CFTimeInterval(duration)
      positionX.additive = true
      positionX.repeatCount = repeatCount
      positionX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(positionX, forKey: "positionX")
      return
    case .Swing:
      let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
      animation.values = [0, 0.3*force, -0.3*force, 0.3*force, 0]
      animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      animation.duration = CFTimeInterval(duration)
      animation.additive = true
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(animation, forKey: "swing")
      return
    default:
      return
    }
  }
  
  /**
   startAnimation method, should be called in layoutSubviews() method
   */
  public func startAnimation() {
    animate()
  }
  
  // MARK: - Animation methods
  public func slideInLeft() {
    let x = -300 * force
    animateInWithX(x);
  }

  public func slideInRight() {
    let x = 300 * force
    animateInWithX(x);
  }

  public func slideInDown() {
    let y = -300 * force
    animateInWithY(y)
  }

  public func slideInUp() {
    let y = 300 * force
    animateInWithY(y)
  }

  public func squeezeInLeft() {
    let x = -300 * force
    let scaleX = 3 * force
    animateInWithX(x, scaleX: scaleX)
  }
  
  public func squeezeInRight() {
    let x = 300 * force
    let scaleX = 3 * force
    animateInWithX(x, scaleX: scaleX)
  }
  
  public func squeezeInDown() {
    let y = -300 * force
    let scaleY = 3 * force
    animateInWithY(y, scaleY: scaleY)
  }
  
  public func squeezeInUp() {
    let y = 300 * force
    let scaleY = 3 * force
    animateInWithY(y, scaleY: scaleY)
  }
  
  public func fadeInLeft() {
    alpha = 0
    slideInLeft()
  }
  
  public func fadeInRight() {
    alpha = 0
    slideInRight()
  }
  
  public func fadeInDown() {
    alpha = 0
    slideInDown()
  }
  
  public func fadeInUp() {
    alpha = 0
    slideInUp()
  }

  public func fadeIn() {
    alpha = 0
    animateWithAlpha(1)
  }

  public func fadeOut() {
    alpha = 1
    animateWithAlpha(0)
  }
  
  public func fadeOutIn() {
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.fromValue = 1
    animation.toValue = 0
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    animation.duration = CFTimeInterval(duration)
    animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
    animation.autoreverses = true
    layer.addAnimation(animation, forKey: "fade")
  }
  
  public func zoomIn() {
    let scaleX = 2 * force
    let scaleY = 2 * force
    alpha = 0
    let toAlpha: CGFloat = 1
    animateInWithScaleX(scaleX, scaleY: scaleY, alpha: toAlpha)
  }
  
  public func zoomOut() {
    let scaleX = 2 * force
    let scaleY = 2 * force
    alpha = 1
    let toAlpha: CGFloat = 0
    animateOutWithScaleX(scaleX, scaleY: scaleY, alpha: toAlpha)
  }

  // MARK: - Private
  private func animateInWithX(x: CGFloat) {
    animateIn(x, 0, 1, 1, 1);
  }

  private func animateInWithY(y: CGFloat) {
    animateIn(0, y, 1, 1, 1);
  }

  private func animateInWithX(x: CGFloat, scaleX: CGFloat) {
    animateIn(x, 0, scaleX, 1, 1);
  }
  
  private func animateInWithY(y: CGFloat, scaleY: CGFloat) {
    animateIn(0, y, 1, scaleY, 1);
  }
  
  private func animateInWithScaleX(scaleX: CGFloat, scaleY: CGFloat, alpha: CGFloat) {
    animateIn(0, 0, scaleX, scaleY, alpha)
  }
  
  private func animateOutWithScaleX(scaleX: CGFloat, scaleY: CGFloat, alpha: CGFloat) {
    animateOut(0, 0, scaleX, scaleY, alpha)
  }
  
  private func animateWithAlpha(alpha: CGFloat, completion:((Bool) -> Void)? = nil) {
    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
      self.alpha = alpha
      }, completion:completion)
  }

  private func animateIn(x: CGFloat, _ y: CGFloat, _ scaleX: CGFloat, _ scaleY: CGFloat, _ alpha: CGFloat, completion:((Bool) -> Void)? = nil) {
    let translate = CGAffineTransformMakeTranslation(x, y)
    let scale = CGAffineTransformMakeScale(scaleX, scaleY)
    let translateAndScale = CGAffineTransformConcat(translate, scale)
    transform = translateAndScale

    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
      self.transform = CGAffineTransformIdentity
      self.alpha = alpha
    }, completion:completion)
  }

  private func animateOut(x: CGFloat, _ y: CGFloat, _ scaleX: CGFloat, _ scaleY: CGFloat, _ alpha: CGFloat, completion:((Bool) -> Void)? = nil) {
    transform = CGAffineTransformIdentity

    let translate = CGAffineTransformMakeTranslation(x, y)
    let scale = CGAffineTransformMakeScale(scaleX, scaleY)
    let translateAndScale = CGAffineTransformConcat(translate, scale)

    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
      self.transform = translateAndScale
      self.alpha = alpha
    }, completion:completion)
  }
}
