//
//  Created by Jake Lin on 12/5/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol FillDesignable {
  var fillColor: UIColor? { get set }
  var predefinedColor: ColorType? { get set }
  var opacity: CGFloat { get set }
}

public extension FillDesignable where Self: UIView {
  public func configureFillColor() {
    if let fillColor = fillColor {
      backgroundColor = fillColor
    } else if let predefinedColor = predefinedColor?.color {
      backgroundColor = predefinedColor
    }
  }

  public func configureOpacity() {
    if !opacity.isNaN && opacity >= 0 && opacity <= 1 {
      alpha = opacity

      // Make better performance
      if opacity == 1 {
        isOpaque = true
      }
    }
  }
}

public extension FillDesignable where Self: UITableViewCell {
  public func configureFillColor() {
    if let fillColor = fillColor {
      backgroundColor = fillColor
      contentView.backgroundColor = fillColor
    } else if let predefinedColor = predefinedColor?.color {
      backgroundColor = predefinedColor
      contentView.backgroundColor = predefinedColor
    }
  }
}

private extension FillDesignable {
  
  func predefinedColor(string predefinedColor: String?) -> UIColor? {
    return ColorType(rawValue: predefinedColor ?? "")?.color
  }
  
}
