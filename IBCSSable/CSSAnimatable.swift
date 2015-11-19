//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol CSSAnimatable {
  
  // Doesn't support animation in IB
  // var animationPreview: Bool { get set }
  
  var animationType: String { get set }
  var duration: Double { get set }
  var delay: Double { get set }
  var damping: CGFloat { get set }
  var velocity: CGFloat { get set }
  
  func customLayoutSubviews()
}

public extension CSSAnimatable where Self: UIView {
  private func animate() {
    
  }
  
  func customLayoutSubviews() {
    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
      switch(self.animationType) {
      case AnimationType.BounceLeft.rawValue:
        self.center.x -= 100
      case AnimationType.BounceRight.rawValue:
        self.center.x += 100
      default:
        break
      }
      }, completion: { (completed) in
//        self.animationPreview = true
    })
  }
}
