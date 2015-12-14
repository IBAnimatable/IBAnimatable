//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol MaskDesignable {
  var maskType: String { get set }
}

public extension MaskDesignable where Self: UIView {
  public func configMask() {
    guard let maskType = MaskType(rawValue: maskType) else {
      return
    }
    
    switch(maskType) {
    case .Circle:
      maskCircle()
    }
  }
  
  // MARK: - Private
  private func maskCircle() {
    let circle = CAShapeLayer()
    var minHeight: CGFloat
    var minBounds: CGRect
    if (bounds.width != bounds.height) {
      minHeight = bounds.width
      minBounds = bounds
    }
    else {
      minHeight = min(bounds.width, bounds.height)
      minBounds = CGRectMake(0, 0, minHeight, minHeight)
    }
    
    circle.path = UIBezierPath(roundedRect: minBounds, cornerRadius: minHeight).CGPath
    circle.fillColor = UIColor.blackColor().CGColor
    layer.mask = circle
  }
}