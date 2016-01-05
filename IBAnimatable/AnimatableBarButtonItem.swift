//
//  Created by Jake Lin on 12/16/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableBarButtonItem: UIBarButtonItem, BarButtonItemDesignable, Animatable {
  // MARK: - BarButtonItemDesignable
  @IBInspectable public var roundedImage: UIImage?
  
  // MARK: - Lifecycle
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configDesignableProperties()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    configDesignableProperties()
  }

  // TODO: animations
//  public override func layoutSubviews() {
//    super.layoutSubviews()
//    
//    autoRunAnimation()
//  }
  
  // MARK: - Animatable
  @IBInspectable public var animationType: String?
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = 0.7
  @IBInspectable public var delay: Double = 0
  @IBInspectable public var damping: CGFloat = 0.7
  @IBInspectable public var velocity: CGFloat = 0.7
  @IBInspectable public var force: CGFloat = 1
  @IBInspectable public var repeatCount: Float = 1
  
  // MARK: - Private
  private func configDesignableProperties() {
    confingBarButtonItemImage()
  }
}
