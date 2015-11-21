//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol Animatable {
  
  // Doesn't support animation in IB
  // var animationPreview: Bool { get set }
  
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
   customLayoutSubviews method, should be called in layoutSubviews() method
   */
  func customLayoutSubviews()
  
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
    var scaleX: CGFloat = 0
    var scaleY: CGFloat = 0
  
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
    default:
      return
    }
    
    let translate = CGAffineTransformMakeTranslation(x, y)
    let scale = CGAffineTransformMakeScale(scaleX, scaleY)
    let translateAndScale = CGAffineTransformConcat(translate, scale)
    
    self.transform = translateAndScale

    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
      self.transform = CGAffineTransformIdentity
      }, completion:nil)
  }
  
  func customLayoutSubviews() {
    animate()
  }
}
