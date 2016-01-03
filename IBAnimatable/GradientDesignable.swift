//
//  Created by Jake Lin on 12/4/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol GradientDesignable {
  var startColor: UIColor? { get set }
  var endColor: UIColor? { get set }
  var startPoint: String? { get set }
}

public extension GradientDesignable where Self: UIView {
  public func configGradent() {
    // Return if both colors are unset.
    guard let unwrappedStartColor = startColor, unwrappedEndColor = endColor else {
      return
    }
    
    // Default value is `.Top`
    var startPointString = "Top"
    if let unwrappedStartPoint = startPoint, _ = GradientStartPoint(rawValue: unwrappedStartPoint) {
      startPointString = unwrappedStartPoint
    }
    
    let gradientView = DesignableGradientView(frame: self.bounds)
    gradientView.startColor = unwrappedStartColor
    gradientView.endColor = unwrappedEndColor
    gradientView.startPoint = startPointString
    
    if layer.cornerRadius > 0 {
      gradientView.cornerRadius = layer.cornerRadius
    }
    
    gradientView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    self.insertSubview(gradientView, atIndex: 0)
    gradientView.configGradient()
  }
}
