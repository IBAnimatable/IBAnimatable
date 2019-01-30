//
//  Created by Jake Lin on 12/5/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol FillDesignable: class {
  var fillColor: UIColor? { get set }
  var predefinedColor: ColorType? { get set }
  var opacity: CGFloat { get set }
}

// MARK: - UIView

public extension FillDesignable where Self: UIView {
  func configureFillColor() {
    configureFillColor(in: self)
  }

  func configureOpacity() {
    configureOpacity(in: self)
  }
}

// MARK: - UITableViewCell

public extension FillDesignable where Self: UITableViewCell {
  func configureFillColor() {
    if let fillColor = fillColor {
      backgroundColor = fillColor
      contentView.backgroundColor = fillColor
    } else if let predefinedColor = predefinedColor?.color {
      backgroundColor = predefinedColor
      contentView.backgroundColor = predefinedColor
    }
  }
}

// MARK: - UICollectionViewCell

public extension FillDesignable where Self: UICollectionViewCell {
  func configureFillColor() {
    if let fillColor = fillColor {
      backgroundColor = fillColor
      contentView.backgroundColor = fillColor
    } else if let predefinedColor = predefinedColor?.color {
      backgroundColor = predefinedColor
      contentView.backgroundColor = predefinedColor
    }
  }
}

// MARK: - Common

extension FillDesignable {

  func configureFillColor(in view: UIView) {
    if let fillColor = fillColor {
      view.backgroundColor = fillColor
    } else if let predefinedColor = predefinedColor?.color {
      view.backgroundColor = predefinedColor
    }
  }

  func configureOpacity(in view: UIView) {
    guard !opacity.isNaN && opacity >= 0 && opacity <= 1 else {
      return
    }

    view.alpha = opacity
    // Make better performance
    view.isOpaque = opacity == 1
  }

  private func predefinedColor(string predefinedColor: String?) -> UIColor? {
    return ColorType(rawValue: predefinedColor ?? "")?.color
  }

}
