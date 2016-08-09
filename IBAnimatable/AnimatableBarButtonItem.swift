//
//  Created by Jake Lin on 12/16/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableBarButtonItem: UIBarButtonItem, BarButtonItemDesignable, Animatable {
  // MARK: - BarButtonItemDesignable
  @IBInspectable public var roundedImage: UIImage?
  
  // MARK: - Lifecycle
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configInspectableProperties()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    configInspectableProperties()
  }

  // TODO: animations
//  public override func layoutSubviews() {
//    super.layoutSubviews()
//    
//    autoRunAnimation()
//  }
  
  // MARK: - Animatable
  public var animationType: AnimationType = .none
  @IBInspectable var _animationType: String? {
    didSet {
      animationType = AnimationType(string: _animationType)
    }
  }
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = Double.nan
  @IBInspectable public var delay: Double = Double.nan
  @IBInspectable public var damping: CGFloat = CGFloat.nan
  @IBInspectable public var velocity: CGFloat = CGFloat.nan
  @IBInspectable public var force: CGFloat = CGFloat.nan
  @IBInspectable public var repeatCount: Float = Float.nan
  
  // MARK: - Private
  private func configInspectableProperties() {
//    configAnimatableProperties()
    confingBarButtonItemImage()
  }
}
