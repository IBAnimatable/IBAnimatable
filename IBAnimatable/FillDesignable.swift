//
//  Created by Jake Lin on 12/5/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol FillDesignable {
  var fillColor: UIColor? { get set }
  var predefinedColor: String? { get set }
  var opacity: CGFloat { get set }
}

public extension FillDesignable where Self: UIView {
  public func configFillColor() {
    if let unwrappedFillColor = fillColor {
      backgroundColor = unwrappedFillColor
    } else if let unwrappedPredefinedColor = predefinedColorFromString(predefinedColor) {
      backgroundColor = unwrappedPredefinedColor
    }
  }

  public func configOpacity() {
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
  public func configFillColor() {
    if let unwrappedFillColor = fillColor {
      backgroundColor = unwrappedFillColor
      contentView.backgroundColor = unwrappedFillColor
    } else if let unwrappedPredefinedColor = predefinedColorFromString(predefinedColor) {
      backgroundColor = unwrappedPredefinedColor
      contentView.backgroundColor = unwrappedPredefinedColor
    }
  }
}

private extension FillDesignable {
  
  func predefinedColorFromString(_ predefinedColor: String?) -> UIColor? {
    guard let unwrappedColorTypeString = predefinedColor, colorType = ColorType(rawValue: unwrappedColorTypeString) else {
      return nil
    }
    
    switch colorType {
    case .flatEmerland:
      return UIColor(red: 46 / 255, green:  204 / 255, blue:  113 / 255, alpha: 1.0)
    case .flatPomegranate:
      return UIColor(red: 192 / 255, green:  57 / 255, blue:  43 / 255, alpha: 1.0)
    case .flatWetAsphalt:
      return UIColor(red: 52 / 255, green:  73 / 255, blue:  94 / 255, alpha: 1.0)
    case .flatTurquoise:
      return UIColor(red: 26 / 255, green:  188 / 255, blue:  156 / 255, alpha: 1.0)
    case .flatConcrete:
      return UIColor(red: 149 / 255, green:  165 / 255, blue:  166 / 255, alpha: 1.0)
    case .flatOrange:
      return UIColor(red: 243 / 255, green:  156 / 255, blue:  18 / 255, alpha: 1.0)
    case .flatAsbestos:
      return UIColor(red: 127 / 255, green:  140 / 255, blue:  141 / 255, alpha: 1.0)
    case .flatPeterRiver:
      return UIColor(red: 52 / 255, green:  152 / 255, blue:  219 / 255, alpha: 1.0)
    case .flatSilver:
      return UIColor(red: 189 / 255, green:  195 / 255, blue:  199 / 255, alpha: 1.0)
    case .flatSunFlower:
      return UIColor(red: 241 / 255, green:  196 / 255, blue:  15 / 255, alpha: 1.0)
    case .flatAmethyst:
      return UIColor(red: 155 / 255, green:  89 / 255, blue:  182 / 255, alpha: 1.0)
    case .flatAlizarin:
      return UIColor(red: 231 / 255, green:  76 / 255, blue:  60 / 255, alpha: 1.0)
    case .flatGreenSea:
      return UIColor(red: 22 / 255, green:  160 / 255, blue:  133 / 255, alpha: 1.0)
    case .flatBelizeHole:
      return UIColor(red: 41 / 255, green:  128 / 255, blue:  185 / 255, alpha: 1.0)
    case .flatNephritis:
      return UIColor(red: 39 / 255, green:  174 / 255, blue:  96 / 255, alpha: 1.0)
    case .flatMidnightBlue:
      return UIColor(red: 44 / 255, green:  62 / 255, blue:  80 / 255, alpha: 1.0)
    case .flatClouds:
      return UIColor(red: 236 / 255, green:  240 / 255, blue:  241 / 255, alpha: 1.0)
    case .flatWisteria:
      return UIColor(red: 142 / 255, green:  68 / 255, blue:  173 / 255, alpha: 1.0)
    case .flatCarrot:
      return UIColor(red: 230 / 255, green:  126 / 255, blue:  34 / 255, alpha: 1.0)
    case .flatPumpkin:
      return UIColor(red: 211 / 255, green:  84 / 255, blue:  0 / 255, alpha: 1.0)
    }
  }
  
}
