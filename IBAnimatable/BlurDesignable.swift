//
//  Created by Jake Lin on 11/23/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol BlurDesignable {
  /**
   blur effect style: `ExtraLight`, `Light` or `Dark`
   */
  var blurEffectStyle: String? { get set }
  var vibrancyEffectStyle: String? { get set }
  var blurOpacity: CGFloat { get set }
}

public extension BlurDesignable where Self: UIView {
  /**
   configBlurEffectStyle method, should be called in layoutSubviews() method
   */
  public func configBlurEffectStyle() {
    guard let unwrappedBlurEffectStyle = blurEffectStyle, style = blurEffectStyle(from: unwrappedBlurEffectStyle) else {
      return
    }

    guard let blurEffectStyle = BlurEffectStyle(rawValue: unwrappedBlurEffectStyle) else {
      return
    }
    
    let style: UIBlurEffectStyle
    let blurEffectView = createVisualEffectView(UIBlurEffect(style: style))
    if let unwrappedVibrancyStyle = vibrancyEffectStyle, vibrancyStyle = blurEffectStyle(from: unwrappedVibrancyStyle) {
      let vibrancyEffectView = createVisualEffectView(UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: vibrancyStyle)))
      vibrancyEffectView.addSubview(UIImageView(image: UIImage(named: "checked")))
      blurEffectView.contentView.addSubview(vibrancyEffectView)
    }
    insertSubview(blurEffectView, atIndex: 0)
  }

  private func createVisualEffectView(effect: UIVisualEffect) -> UIVisualEffectView {
    let visualEffectView = UIVisualEffectView(effect: effect)
    visualEffectView.alpha = blurOpacity.isNaN ? 1.0 : blurOpacity
    if layer.cornerRadius > 0 {
      visualEffectView.layer.cornerRadius = layer.cornerRadius
      visualEffectView.clipsToBounds = true
    }

    visualEffectView.frame = bounds
    visualEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    return visualEffectView
  }

}


private extension BlurDesignable {

  func blurEffectStyle(from blurEffectStyle: String) -> UIBlurEffectStyle? {
    var style: UIBlurEffectStyle?
    guard let blurEffectStyle = BlurEffectStyle(rawValue: blurEffectStyle) else {
      return nil
    }

    switch blurEffectStyle {
    case .extraLight:
      style = .extraLight
    case .light:
      style = .light
    case .dark:
      style = .dark
    }
    
    let blurEffect = UIBlurEffect(style: style)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = bounds
    let opacity = blurOpacity.isNaN ? 1.0 : blurOpacity // Default is 1.0
    blurEffectView.alpha = opacity
    if layer.cornerRadius > 0 {
      blurEffectView.layer.cornerRadius = layer.cornerRadius
      blurEffectView.clipsToBounds = true
    }
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    insertSubview(blurEffectView, at: 0)
    return style
  }
}
