//
//  Created by Jake Lin on 12/4/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol GradientDesignable {
  var startColor: UIColor { get set }
  var endColor: UIColor { get set }
  var startPoint: String { get set }
}

public extension GradientDesignable where Self : UIView {
  public func configGradent() {
    // Return if both colors are unset.
    if (startColor == UIColor.clearColor() && endColor == UIColor.clearColor()) {
      return
    }
    
    guard let _ = GradientStartPoint(rawValue: startPoint) else {
      return
    }
    
    let gradientView = DesignableGradientView(frame: self.bounds)
    gradientView.startColor = startColor
    gradientView.endColor = endColor
    gradientView.startPoint = startPoint
    if (layer.cornerRadius > 0) {
      gradientView.cornerRadius = layer.cornerRadius
    }
    
    gradientView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    self.insertSubview(gradientView, atIndex: 0)
  }
}