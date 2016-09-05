//
//  Created by Jake Lin on 11/23/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

/// A protocol provides blur designable feature.
public protocol BlurDesignable {
  /**
   Blur effect style: `ExtraLight`, `Light` or `Dark`
   */
  var blurEffectStyle: UIBlurEffectStyle? { get set }

  /**
   Vibrancy effect style: `ExtraLight`, `Light` or `Dark`. Once specify the Vibrancy effect style, all subviews will apply this vibrancy effect.
   */
  var vibrancyEffectStyle: UIBlurEffectStyle? { get set }
  
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
    // Remove the existing visual effect view
    subviews.flatMap { $0 as? PrivateVisualEffectView }
      .forEach { $0.removeFromSuperview() }
    
    guard let blurEffectStyle = blurEffectStyle else {
      return
    }

    let blurEffectView = createVisualEffectView(effect: UIBlurEffect(style: blurEffectStyle))
    
    // If `vibrancyEffectStyle` has been set, add `vibrancyEffectView` into `blurEffectView`.
    if let vibrancyEffectStyle = vibrancyEffectStyle {
      let blurEffectStyleForVibrancy = UIBlurEffect(style: vibrancyEffectStyle)
      let vibrancyEffectView = createVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffectStyleForVibrancy))
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
    let visualEffectView = PrivateVisualEffectView(effect: effect)
    visualEffectView.alpha = blurOpacity.isNaN ? 1.0 : blurOpacity
    if layer.cornerRadius > 0 {
      visualEffectView.layer.cornerRadius = layer.cornerRadius
      visualEffectView.clipsToBounds = true
    }

    visualEffectView.frame = bounds
    visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return visualEffectView
  }
}

/// Private class of visual effect view used in `BlurDesignable` only
private class PrivateVisualEffectView: UIVisualEffectView {

}
