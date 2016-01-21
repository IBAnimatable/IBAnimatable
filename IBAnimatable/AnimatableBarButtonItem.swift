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
  #if TARGET_INTERFACE_BUILDER
    @IBInspectable public var animationType: String?
  #else
    public var animationType: AnimationType?
    public var animationTypeRaw: String? {
      get {
        return self.animationType.debugDescription
      }
      set {
        self.animationType = AnimationType(rawValue: newValue ?? "")
      }
    }
  #endif
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = Double.NaN
  @IBInspectable public var delay: Double = Double.NaN
  @IBInspectable public var damping: CGFloat = CGFloat.NaN
  @IBInspectable public var velocity: CGFloat = CGFloat.NaN
  @IBInspectable public var force: CGFloat = CGFloat.NaN
  @IBInspectable public var repeatCount: Float = Float.NaN
  
  // MARK: - Private
  private func configInspectableProperties() {
//    configAnimatableProperites()
    confingBarButtonItemImage()
  }
}
