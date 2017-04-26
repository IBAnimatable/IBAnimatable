//
//  Created by Jake Lin on 12/1/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol CornerDesignable: class {
  /**
   `border-radius`
   */
  var cornerRadius: CGFloat { get set }

  /**
   corner side: Top Left, Top Right, Bottom Left or Bottom Right, if not specified, all corner sides will display,
   */
  var cornerSides: CornerSides { get set }
}

public extension CornerDesignable where Self: UICollectionViewCell {
  public func configureCornerRadius() {
    if !cornerRadius.isNaN && cornerRadius > 0 {

      // Remove any previous corner mask, i.e. coming from UIView type implementation
      if layer.mask?.name == "cornerSideLayer" {
        layer.mask?.removeFromSuperlayer()
      }
      layer.cornerRadius = 0.0

      if cornerSides == .allSides {
        contentView.layer.cornerRadius = cornerRadius
      } else {
        contentView.layer.cornerRadius = 0.0

        // if a layer mask is specified, remove it
        contentView.layer.mask?.removeFromSuperlayer()

        contentView.layer.mask = cornerSidesLayer()
      }

      contentView.layer.masksToBounds = true
    } else {
      contentView.layer.masksToBounds = false
    }
  }
}

public extension CornerDesignable where Self: UIView {
  public func configureCornerRadius() {
    if !cornerRadius.isNaN && cornerRadius > 0 {
      if cornerSides == .allSides {
        layer.cornerRadius = cornerRadius
      } else {
        layer.cornerRadius = 0.0

        // if a layer mask is specified, remove it
        layer.mask?.removeFromSuperlayer()

        layer.mask = cornerSidesLayer()
      }
    }
  }

  fileprivate func cornerSidesLayer() -> CAShapeLayer {
    let cornerSideLayer = CAShapeLayer()
    cornerSideLayer.name = "cornerSideLayer"
    cornerSideLayer.frame = CGRect(origin: .zero, size: bounds.size)

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

    cornerSideLayer.path = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: roundingCorners,
                                        cornerRadii: cornerRadii).cgPath

    return cornerSideLayer
  }
}
