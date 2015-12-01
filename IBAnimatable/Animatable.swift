//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol Animatable {
  
  /**
    Animation Type
      slideLeft
      slideRight
      slideDown
      slideUp
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
  func animate() {
    guard let animationType = AnimationType(rawValue: animationType) else {
      return
    }
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    var scaleX: CGFloat = 1
    var scaleY: CGFloat = 1
  
    var willDisappear = false
    
    switch(animationType) {
    case .SlideLeft:
      x = -300 * force
    case .SlideRight:
      x = 300 * force
    case .SlideDown:
      y = -300 * force
    case .SlideUp:
      y = 300 * force
    case .SqueezeLeft:
      x = -300 * force
      scaleX = 3 * force
    case .SqueezeRight:
      x = 300 * force
      scaleX = 3 * force
    case .SqueezeDown:
      y = -300 * force
      scaleY = 3 * force
    case .SqueezeUp:
      y = 300 * force
      scaleY = 3 * force
    case .FadeIn:
      alpha = 0
    case .FadeOut:
      willDisappear = true
    case .FadeOutIn:
      let animation = CABasicAnimation()
      animation.keyPath = "opacity"
      animation.fromValue = 1
      animation.toValue = 0
      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      animation.duration = CFTimeInterval(duration)
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      animation.autoreverses = true
      layer.addAnimation(animation, forKey: "fade")
      return
    case .FadeInLeft:
      x = 300 * force
      alpha = 0
    case .FadeInRight:
      x = -300 * force
      alpha = 0
    case .FadeInDown:
      y = -300 * force
      alpha = 0
    case .FadeInUp:
      y = 300 * force
      alpha = 0
    case .ZoomIn:
      scaleX = 2 * force
      scaleY = 2 * force
      alpha = 0
    case .ZoomOut:
      scaleX = 2 * force
      scaleY = 2 * force
      let scale = CGAffineTransformMakeScale(scaleX, scaleY)
      UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
        self.transform = scale
        self.alpha = 0
        }, completion:nil)
      return
    case .Shake:
      let animation = CAKeyframeAnimation()
      animation.keyPath = "position.x"
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
      let animation = CAKeyframeAnimation()
      animation.keyPath = "transform.scale"
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
      let morphX = CAKeyframeAnimation()
      morphX.keyPath = "transform.scale.x"
      morphX.values = [1, 1.3*force, 0.7, 1.3*force, 1]
      morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      morphX.duration = CFTimeInterval(duration)
      morphX.repeatCount = repeatCount
      morphX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(morphX, forKey: "morphX")
      
      let morphY = CAKeyframeAnimation()
      morphY.keyPath = "transform.scale.y"
      morphY.values = [1, 0.7, 1.3*force, 0.7, 1]
      morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      morphY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      morphY.duration = CFTimeInterval(duration)
      morphY.repeatCount = repeatCount
      morphY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(morphY, forKey: "morphY")
      return
    case .Squeeze:
      let squeezeX = CAKeyframeAnimation()
      squeezeX.keyPath = "transform.scale.x"
      squeezeX.values = [1, 1.5*force, 0.5, 1.5*force, 1]
      squeezeX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      squeezeX.duration = CFTimeInterval(duration)
      squeezeX.repeatCount = repeatCount
      squeezeX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(squeezeX, forKey: "squeezeX")
      
      let squeezeY = CAKeyframeAnimation()
      squeezeY.keyPath = "transform.scale.y"
      squeezeY.values = [1, 0.5, 1, 0.5, 1]
      squeezeY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      squeezeY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      squeezeY.duration = CFTimeInterval(duration)
      squeezeY.repeatCount = repeatCount
      squeezeY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(squeezeY, forKey: "squeezeY")
      return
    case .Flash:
      let animation = CABasicAnimation()
      animation.keyPath = "opacity"
      animation.fromValue = 1
      animation.toValue = 0
      animation.duration = CFTimeInterval(duration)
      animation.repeatCount = repeatCount * 2.0
      animation.autoreverses = true
      animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(animation, forKey: "flash")
      return
    case .Wobble:
      let rotation = CAKeyframeAnimation()
      rotation.keyPath = "transform.rotation"
      rotation.values = [0, 0.3*force, -0.3*force, 0.3*force, 0]
      rotation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
      rotation.duration = CFTimeInterval(duration)
      rotation.additive = true
      rotation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
      layer.addAnimation(rotation, forKey: "rotation")
      
      let positionX = CAKeyframeAnimation()
      positionX.keyPath = "position.x"
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
      let animation = CAKeyframeAnimation()
      animation.keyPath = "transform.rotation"
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
    
    let translate = CGAffineTransformMakeTranslation(x, y)
    let scale = CGAffineTransformMakeScale(scaleX, scaleY)
    let translateAndScale = CGAffineTransformConcat(translate, scale)
    
    self.transform = translateAndScale

    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
      self.transform = CGAffineTransformIdentity
      if willDisappear {
        self.alpha = 0
      }
      else {
        self.alpha = 1
      }
      }, completion:nil)
  }
  
  /**
   startAnimation method, should be called in layoutSubviews() method
   */
  func startAnimation() {
    animate()
  }
}
