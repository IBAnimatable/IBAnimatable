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

// MARK: - UIView

public extension CornerDesignable where Self: UIView {

  public func configureCornerRadius() {
    configureCornerRadius(in: self)
  }

}

// MARK: - UICollectionViewCell

public extension CornerDesignable where Self: UICollectionViewCell {

  public func configureCornerRadius() {
    if !cornerRadius.isNaN && cornerRadius > 0 {
      // Remove any previous corner mask, i.e. coming from UIView type implementation
      if layer.mask?.name == "cornerSideLayer" {
        layer.mask?.removeFromSuperlayer()
      }
      layer.cornerRadius = 0.0

      applyCorner(in: contentView)
      contentView.layer.masksToBounds = true
    } else {
      contentView.layer.masksToBounds = false
    }
  }

}

// MARK: - Common

extension CornerDesignable {

  func configureCornerRadius(in view: UIView) {
    guard !cornerRadius.isNaN && cornerRadius > 0 else {
      return
    }

    applyCorner(in: view)
  }

  private func applyCorner(in view: UIView) {
    if cornerSides == .allSides {
      view.layer.cornerRadius = cornerRadius
    } else {
      view.layer.cornerRadius = 0.0
      // if a layer mask is specified, remove it
      view.layer.mask?.removeFromSuperlayer()
      view.layer.mask = cornerSidesLayer(inRect: view.bounds)
    }
  }

  private func cornerSidesLayer(inRect bounds: CGRect) -> CAShapeLayer {
    let cornerSideLayer = CAShapeLayer()
    cornerSideLayer.name = "cornerSideLayer"
    cornerSideLayer.frame = CGRect(origin: .zero, size: bounds.size)

    let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
    let roundingCorners: UIRectCorner = cornerSides.rectCorner
    cornerSideLayer.path = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: roundingCorners,
                                        cornerRadii: cornerRadii).cgPath
    return cornerSideLayer
  }

}
