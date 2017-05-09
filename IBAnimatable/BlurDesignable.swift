//
//  Created by Jake Lin on 11/23/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

/// A protocol provides blur designable feature.
public protocol BlurDesignable: class {
  /**
   Blur effect style: `extraLight`, `light`, `dark`, `regular` (iOS 10+) or `prominent` (iOS 10+).
   */
  var blurEffectStyle: UIBlurEffectStyle? { get set }

  /**
   Vibrancy effect style: `extraLight`, `light`, `dark`, `regular` (iOS 10+) or `prominent` (iOS 10+). Once specify the vibrancy effect style, all subviews of blur effect view will apply this vibrancy effect. The property should set once. Because once we use `UIVisualEffectView`, Apple uses a private class like `_UIVisualEffectContentView` to contain subviews which will change the view hierarchy. After that, we are not able to restore the original view hierarchy. Also, the Auto Layout constraints will be broken when the system change the view hierarchy. We need to manually re-set up the constraints or use Autoresizing masks to layout the subviews.
   */
  var vibrancyEffectStyle: UIBlurEffectStyle? { get set }

  /**
   Blur opacity: The opacity of UI element using blur effect. The default value is 1.0 if not specified. There is some performance penalty when we use this property.
   */
  var blurOpacity: CGFloat { get set }
}

public extension BlurDesignable where Self: UIView {
  /**
   configureBlurEffectStyle method, should be called in layoutSubviews() method
   */
  public func configureBlurEffectStyle() {
    configureBlurEffectStyle(for: self)
  }
  public func configureBlurEffectStyle(for blurableView: UIView) {
    // Used for caching the previous visual effect view
    var privateVisualEffectView: PrivateVisualEffectView?

    // Remove the existing visual effect view
    blurableView.subviews.flatMap { $0 as? PrivateVisualEffectView }
      .forEach {
        privateVisualEffectView = $0 // Cache it for the subviews
        $0.removeFromSuperview()
      }

    guard let blurEffectStyle = blurEffectStyle else {
      return
    }

    let blurEffectView = makeVisualEffectView(effect: UIBlurEffect(style: blurEffectStyle))

    // If `vibrancyEffectStyle` has been set, add `vibrancyEffectView` into `blurEffectView`.
    if let vibrancyEffectStyle = vibrancyEffectStyle {
      let blurEffectStyleForVibrancy = UIBlurEffect(style: vibrancyEffectStyle)
      let vibrancyEffectView = makeVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffectStyleForVibrancy))
      blurableView.subviews.forEach {
        vibrancyEffectView.contentView.addSubview($0)
      }

      // If privateVisualEffectView is not `nil`, re-add them to the `vibrancyEffectView.contentView`
      privateVisualEffectView?.contentView.subviews.forEach {
        vibrancyEffectView.contentView.addSubview($0)
      }
      blurEffectView.contentView.addSubview(vibrancyEffectView)
    } else {
      // If privateVisualEffectView is not `nil`, re-add them back to the subviews of original UI element.
      privateVisualEffectView?.contentView.subviews.forEach {
        blurableView.addSubview($0)
      }
    }

    blurableView.insertSubview(blurEffectView, at: 0)
  }
}

private extension BlurDesignable where Self: UIView {
  func makeVisualEffectView(effect: UIVisualEffect) -> UIVisualEffectView {
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

public extension BlurDesignable where Self: UITableView {
  public func configureBackgroundBlurEffectStyle() {
    guard let blurableView = backgroundView else {
      separatorEffect = nil
      return
    }
    configureBlurEffectStyle(for: blurableView)
    guard let blurEffectStyle = blurEffectStyle else {
      return
    }
    if let style = vibrancyEffectStyle {
      separatorEffect = UIVibrancyEffect(blurEffect: UIBlurEffect(style: style))
    } else {
      separatorEffect = UIBlurEffect(style: blurEffectStyle)
    }
  }
}

/// Private class of visual effect view used in `BlurDesignable` only
private class PrivateVisualEffectView: UIVisualEffectView {

}
