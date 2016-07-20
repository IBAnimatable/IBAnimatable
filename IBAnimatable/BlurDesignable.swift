//
//  Created by Jake Lin on 11/23/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

/// A protocol provides blur designable feature.
public protocol BlurDesignable {
  /**
   Blur effect style: `ExtraLight`, `Light` or `Dark`
   */
  var blurEffectStyle: String? { get set }

  /**
   Vibrancy effect style: `ExtraLight`, `Light` or `Dark`. Once specify the Vibrancy effect style, all subviews will apply this vibrancy effect.
   */
  var vibrancyEffectStyle: String? { get set }
  
  /**
   Blur opacity: The opacity of UI element using blur effect. The default value is 1.0 if not specified. There is some performance penalty when we use this property.
   */
  var blurOpacity: CGFloat { get set }
}

public extension BlurDesignable where Self: UIView {
  /**
   configBlurEffectStyle method, should be called in layoutSubviews() method
   */
  public func configBlurEffectStyle() {
    guard let unwrappedBlurEffectStyle = blurEffectStyle, blurStyle = getBlurEffectStyle(from: unwrappedBlurEffectStyle) else {
      return
    }
    
    let blurEffectView = createVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    
    // Apply vibrancy effect to all subviews
    if let unwrappedVibrancyStyle = vibrancyEffectStyle, vibrancyStyle = getBlurEffectStyle(from: unwrappedVibrancyStyle) {
      let vibrancyEffect = UIVibrancyEffect(blurEffect: UIBlurEffect(style: vibrancyStyle))
      let vibrancyEffectView = createVisualEffectView(effect: vibrancyEffect)
      subviews.forEach {
        vibrancyEffectView.contentView.addSubview($0)
      }
      blurEffectView.contentView.addSubview(vibrancyEffectView)
    }
    insertSubview(blurEffectView, at: 0)
  }
}


private extension BlurDesignable where Self: UIView {
  
  func createVisualEffectView(effect: UIVisualEffect) -> UIVisualEffectView {
    let visualEffectView = UIVisualEffectView(effect: effect)
    visualEffectView.alpha = blurOpacity.isNaN ? 1.0 : blurOpacity
    if layer.cornerRadius > 0 {
      visualEffectView.layer.cornerRadius = layer.cornerRadius
      visualEffectView.clipsToBounds = true
    }
    
    visualEffectView.frame = bounds
    visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return visualEffectView
  }

  func getBlurEffectStyle(from blurEffectStyle: String) -> UIBlurEffectStyle? {
    guard let blurEffectStyle = BlurEffectStyle(rawValue: blurEffectStyle) else {
      return nil
    }

    let style: UIBlurEffectStyle
    switch blurEffectStyle {
    case .extraLight:
      style = .extraLight
    case .light:
      style = .light
    case .dark:
      style = .dark
    }
    
    return style
  }
}
