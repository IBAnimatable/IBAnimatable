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
    } else if let unwrappedPredefinedColor = predefinedColorFromString(predefinedColor) {
      backgroundColor = unwrappedPredefinedColor
      contentView.backgroundColor = unwrappedPredefinedColor
    }
  }
}

private extension FillDesignable {
  
  func predefinedColorFromString(predefinedColor: String?) -> UIColor? {
    guard let unwrappedColorTypeString = predefinedColor, colorType = ColorType(rawValue: unwrappedColorTypeString) else {
      return nil
    }
    
    switch colorType {
    case .Emerland:
      return UIColor(red: 46 / 255, green:  204 / 255, blue:  113 / 255, alpha: 1.0)
    case .Pomegranate:
      return UIColor(red: 192 / 255, green:  57 / 255, blue:  43 / 255, alpha: 1.0)
    case .WetAsphalt:
      return UIColor(red: 52 / 255, green:  73 / 255, blue:  94 / 255, alpha: 1.0)
    case .Turquoise:
      return UIColor(red: 26 / 255, green:  188 / 255, blue:  156 / 255, alpha: 1.0)
    case .Concrete:
      return UIColor(red: 149 / 255, green:  165 / 255, blue:  166 / 255, alpha: 1.0)
    case .Orange:
      return UIColor(red: 243 / 255, green:  156 / 255, blue:  18 / 255, alpha: 1.0)
    case .Asbestos:
      return UIColor(red: 127 / 255, green:  140 / 255, blue:  141 / 255, alpha: 1.0)
    case .PeterRiver:
      return UIColor(red: 52 / 255, green:  152 / 255, blue:  219 / 255, alpha: 1.0)
    case .Silver:
      return UIColor(red: 189 / 255, green:  195 / 255, blue:  199 / 255, alpha: 1.0)
    case .SunFlower:
      return UIColor(red: 241 / 255, green:  196 / 255, blue:  15 / 255, alpha: 1.0)
    case .Amethyst:
      return UIColor(red: 155 / 255, green:  89 / 255, blue:  182 / 255, alpha: 1.0)
    case .Alizarin:
      return UIColor(red: 231 / 255, green:  76 / 255, blue:  60 / 255, alpha: 1.0)
    case .GreenSea:
      return UIColor(red: 22 / 255, green:  160 / 255, blue:  133 / 255, alpha: 1.0)
    case .BelizeHole:
      return UIColor(red: 41 / 255, green:  128 / 255, blue:  185 / 255, alpha: 1.0)
    case .Nephritis:
      return UIColor(red: 39 / 255, green:  174 / 255, blue:  96 / 255, alpha: 1.0)
    case .MidnightBlue:
      return UIColor(red: 44 / 255, green:  62 / 255, blue:  80 / 255, alpha: 1.0)
    case .Clouds:
      return UIColor(red: 236 / 255, green:  240 / 255, blue:  241 / 255, alpha: 1.0)
    case .Wisteria:
      return UIColor(red: 142 / 255, green:  68 / 255, blue:  173 / 255, alpha: 1.0)
    case .Carrot:
      return UIColor(red: 230 / 255, green:  126 / 255, blue:  34 / 255, alpha: 1.0)
    case .Pumpkin:
      return UIColor(red: 211 / 255, green:  84 / 255, blue:  0 / 255, alpha: 1.0)
    }
  }
  
}