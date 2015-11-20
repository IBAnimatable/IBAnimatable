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
}

public extension Animatable where Self: UIView {
  private func willAnimate() {
    guard let animationType = AnimationType(rawValue: animationType) else {
      return
    }
    switch(animationType) {
    case .SlideLeft:
      self.center.x = 300 * self.force
    case .SlideRight:
      self.center.x -= 300 * self.force
    default:
      break
    }
  }
  
  private func animate() {
    
    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
      let translate = CGAffineTransformMakeTranslation(self.center.x, self.center.y)
      
//      let scale = CGAffineTransformMakeScale(self.transform..scaleX, self.scaleY)
//      let rotate = CGAffineTransformMakeRotation(self.rotate)
//      let translateAndScale = CGAffineTransformConcat(translate, scale)
//      self.transform = CGAffineTransformConcat(rotate, translateAndScale)
//      
      }, completion: { (completed) in
        //        self.animationPreview = true
    })

  }
  
  func customLayoutSubviews() {
    willAnimate()
    animate()
  }
}
