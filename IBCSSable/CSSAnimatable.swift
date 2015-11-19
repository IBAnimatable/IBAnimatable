//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol CSSAnimatable {
  var animationType: String { get set }
  var duration: CGFloat { get set }
  var delay: CGFloat { get set }
  
  func animate()
}

public extension CSSAnimatable where Self: UIView {  
  func animate() {
    UIView.animateWithDuration(Double(duration), delay: Double(delay), usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: { () -> Void in
      switch(self.animationType) {
      case AnimationType.BounceLeft.rawValue:
        self.center.x -= 100
      case AnimationType.BounceRight.rawValue:
        self.center.x += 100
      default:
        break
      }
      }, completion: nil)
  }
}
