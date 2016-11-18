//
//  Created by Jake Lin on 12/1/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol CornerDesignable {
  /**
   `border-radius`
   */
  var cornerRadius: CGFloat { get set }
  
  /**
   corner side: Top Left, Top Right, Bottom Left or Bottom Right, if not specified, all corner sides will display,
   */
  var cornerSides: CornerSides { get set }
}

public extension CornerDesignable where Self: UIView {
  public func configureCornerRadius() {
    if !cornerRadius.isNaN && cornerRadius > 0 {
      if cornerSides == .AllSides {
        layer.cornerRadius = cornerRadius
      } else {
        layer.cornerRadius = 0.0

        // if a layer mask is specified, remove it
        layer.mask?.removeFromSuperlayer()

        // configure corner for specified sides
        let corner = CAShapeLayer()
        corner.name = "cornerSideLayer"
        corner.frame = CGRect(origin: .zero, size: bounds.size)

        let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)

        var roundingCorners: UIRectCorner = []
        if cornerSides.contains(.topLeft) {
          roundingCorners.insert(.topLeft)
        }
        if cornerSides.contains(.topRight) {
          roundingCorners.insert(.topRight)
        }
        if cornerSides.contains(.bottomLeft) {
          roundingCorners.insert(.bottomLeft)
        }
        if cornerSides.contains(.bottomRight) {
          roundingCorners.insert(.bottomRight)
        }

        corner.path = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: roundingCorners,
                                      cornerRadii: cornerRadii).cgPath
        layer.mask = corner
      }
    }
  }
}
