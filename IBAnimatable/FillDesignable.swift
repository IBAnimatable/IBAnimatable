//
//  Created by Jake Lin on 12/5/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol FillDesignable {
  var fillColor: UIColor? { get set }
  var opacity: CGFloat { get set }
}

public extension FillDesignable where Self: UIView {
  public func configFillColor() {
    if let unwrappedFillColor = fillColor {
      backgroundColor = unwrappedFillColor
    }
  }

  public func configOpacity() {
    if !opacity.isNaN && opacity >= 0 && opacity <= 1 {
      alpha = opacity

      // Make better performance
      if opacity == 1 {
        opaque = true
      }
    }
  }
}

public extension FillDesignable where Self: UITableViewCell {
  public func configFillColor() {
    if let unwrappedFillColor = fillColor {
      backgroundColor = unwrappedFillColor
      contentView.backgroundColor = unwrappedFillColor
    }
  }
}
