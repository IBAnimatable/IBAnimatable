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
  var blurEffectStyle: UIBlurEffect.Style? { get set }

  /**
   Vibrancy effect style: `extraLight`, `light`, `dark`, `regular` (iOS 10+) or `prominent` (iOS 10+). Once specify the vibrancy effect style, all subviews of blur effect view will apply this vibrancy effect. The property should set once. Because once we use `UIVisualEffectView`, Apple uses a private class like `_UIVisualEffectContentView` to contain subviews which will change the view hierarchy. After that, we are not able to restore the original view hierarchy. Also, the Auto Layout constraints will be broken when the system change the view hierarchy. We need to manually re-set up the constraints or use Autoresizing masks to layout the subviews.
   */
  var vibrancyEffectStyle: UIBlurEffect.Style? { get set }

  /**
   Blur opacity: The opacity of UI element using blur effect. The default value is 1.0 if not specified. There is some performance penalty when we use this property.
   */
  var blurOpacity: CGFloat { get set }
}

// MARK: - UIView

extension BlurDesignable where Self: UIView {

  public func configureBlurEffectStyle() {
    configureBlurEffectStyle(for: self, in: self)
  }

}

// MARK: - UITableView

extension BlurDesignable where Self: UITableView {
  public func configureBackgroundBlurEffectStyle() {
    guard let blurableView = backgroundView else {
      separatorEffect = nil
      return
    }

    configureBlurEffectStyle(for: blurableView, in: self)
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

// MARK: - Common

extension BlurDesignable {

  func configureBlurEffectStyle(in view: UIView) {
    configureBlurEffectStyle(for: view, in: view)
  }

  // configureBlurEffectStyle method, should be called in layoutSubviews() method
  func configureBlurEffectStyle(for blurableView: UIView, in view: UIView) {
    // Used for caching the previous visual effect view
    var privateVisualEffectView: PrivateVisualEffectView?

    // Remove the existing visual effect view
    blurableView.subviews.compactMap { $0 as? PrivateVisualEffectView }.forEach {
      privateVisualEffectView = $0 // Cache it for the subviews
      $0.removeFromSuperview()
    }

    guard let blurEffectStyle = blurEffectStyle else {
      return
    }

    let blurEffectView = makeVisualEffectView(effect: UIBlurEffect(style: blurEffectStyle), in: view)

    // If `vibrancyEffectStyle` has been set, add `vibrancyEffectView` into `blurEffectView`.
    if let vibrancyEffectStyle = vibrancyEffectStyle {
      let blurEffectStyleForVibrancy = UIBlurEffect(style: vibrancyEffectStyle)
      let vibrancyEffectView = makeVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffectStyleForVibrancy), in: view)
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

  private func makeVisualEffectView(effect: UIVisualEffect, in view: UIView) -> UIVisualEffectView {
    let visualEffectView = PrivateVisualEffectView(effect: effect)
    visualEffectView.alpha = blurOpacity.isNaN ? 1.0 : blurOpacity
    if view.layer.cornerRadius > 0 {
      visualEffectView.layer.cornerRadius = view.layer.cornerRadius
      visualEffectView.clipsToBounds = true
    }

    visualEffectView.frame = view.bounds
    visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return visualEffectView
  }

}

/// Private class of visual effect view used in `BlurDesignable` only
private class PrivateVisualEffectView: UIVisualEffectView {

}
