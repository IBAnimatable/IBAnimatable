//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

/// A protocol provides mask designable feature.
public protocol MaskDesignable: class {
  /**
   The type of the mask used for masking an IBAnimatable UI element.

   When you create a class and conform to `MaskDesignable`, you need to implement this computed property like

   ```
   public var maskType: MaskType = .none {
     didSet {
       configureMask()
       configureBorder()
     }
   }
   ```

   Because Interface Builder doesn't support `enum` for `@IBInspectable` property. You need to create an `internal` property using optional String as the type like
   ```
   @IBInspectable var _maskType: String? {
     didSet {
       maskType = MaskType(string: _maskType)
     }
   }
   ```
   */
  var maskType: MaskType { get set }
}

public extension MaskDesignable where Self: UIView {
  /// Mask the IBAnimatable UI element with provided `maskType`
  public func configureMask(previousMaskType: MaskType) {
    if case .none = maskType {
      // If `previousMaskType` is `.none`, then we will **not** remove `layer.mask` before re-adding it. This allows for custom masks to be preserved.
      if case .none = previousMaskType {
        return
      } else {
        layer.mask?.removeFromSuperlayer()
      }
    } else {
      let path = maskType.bezierPath(in: bounds)
      draw(path)
    }
  }
}

// MARK: - Private helper functions
private extension MaskDesignable where Self: UIView {
  /**
   Draw a Bezier path on `layer.mask` using `CAShapeLayer`.

   - Parameter path: The Bezier path to draw.
   */
  func draw(_ path: UIBezierPath) {
    layer.mask?.removeFromSuperlayer()

    let maskLayer = CAShapeLayer()
    maskLayer.frame = CGRect(origin: .zero, size: bounds.size)
    maskLayer.path = path.cgPath
    layer.mask = maskLayer
  }
}
