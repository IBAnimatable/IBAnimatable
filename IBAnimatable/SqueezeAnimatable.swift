//
//  Created by Jake Lin on 11/20/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol SqueezeAnimatable : PositionAnimatable {
}

public extension SqueezeAnimatable where Self: UIView {
  func animate() {
//    guard let animationType = AnimationType(rawValue: animationType) else {
//      return
//    }
//    
//    var x: CGFloat = 0
//    var y: CGFloat = 0
//    var scaleX: CGFloat = 0
//    var scaleY: CGFloat = 0
//    
//    switch(animationType) {
//    case .SqueezeLeft:
//      x = -300 * force
//      scaleX = 3 * force
//    case .SqueezeRight:
//      x = 300 * force
//      scaleX = 3 * force
//    case .SqueezeDown:
//      y = -300 * force
//      scaleY = 3 * force
//    case .SqueezeUp:
//      y = 300 * force
//      scaleY = 3 * force
//    default:
//      return
//    }
//    
//    let translate = CGAffineTransformMakeTranslation(x, y)
//    let scale = CGAffineTransformMakeScale(scaleX, scaleY)
//    let translateAndScale = CGAffineTransformConcat(translate, scale)
//    
//    self.transform = translateAndScale
//    
//    UIView.animateWithDuration(duration, delay:delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: [], animations: { () -> Void in
//      self.transform = CGAffineTransformIdentity
//      }, completion:nil)
  }
}