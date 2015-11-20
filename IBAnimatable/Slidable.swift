//
//  Created by Jake Lin on 11/20/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol Slidable : PositionAnimatable {
}

public extension Slidable where Self: UIView {
  func animate() {
    guard let animationType = AnimationType(rawValue: animationType) else {
      return
    }
    var x: CGFloat = 0
    var y: CGFloat = 0
    switch(animationType) {
    case .SlideLeft:
      x = -300 * force
    case .SlideRight:
      x = 300 * force
    case .SlideDown:
      y = -300 * force
    case .SlideUp:
      y = 300 * force
    default:
      return
    }
    
    let translate = CGAffineTransformMakeTranslation(x, y)
    self.transform = translate
    
    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
        self.transform = CGAffineTransformIdentity
      }, completion:nil)
  }
}
