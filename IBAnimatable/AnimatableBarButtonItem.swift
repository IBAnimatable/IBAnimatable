//
//  Created by Jake Lin on 12/16/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable
open class AnimatableBarButtonItem: UIBarButtonItem, BarButtonItemDesignable, Animatable {
  // MARK: - BarButtonItemDesignable
  @IBInspectable open var roundedImage: UIImage?

  // MARK: - Lifecycle
  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configureInspectableProperties()
  }

  open override func awakeFromNib() {
    super.awakeFromNib()
    configureInspectableProperties()
  }

  // TODO: animations
//  public override func layoutSubviews() {
//    super.layoutSubviews()
//
//    autoRunAnimation()
//  }

  // MARK: - Animatable
  open var animationType: AnimationType = .none
  @IBInspectable var _animationType: String? {
    didSet {
      animationType = AnimationType(string: _animationType)
    }
  }
  @IBInspectable open var autoRun: Bool = true
  @IBInspectable open var duration: Double = Double.nan
  @IBInspectable open var delay: Double = Double.nan
  @IBInspectable open var damping: CGFloat = CGFloat.nan
  @IBInspectable open var velocity: CGFloat = CGFloat.nan
  @IBInspectable open var force: CGFloat = CGFloat.nan

  // MARK: - Private
  fileprivate func configureInspectableProperties() {
    configureBarButtonItemImage()
  }
}
