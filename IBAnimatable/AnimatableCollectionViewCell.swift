//
//  Created by Tom Baranes on 11/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableCollectionViewCell: UICollectionViewCell, CornerDesignable, FillDesignable, BorderDesignable, TableViewCellDesignable, GradientDesignable, Animatable {
  
  // MARK: - CornerDesignable
  @IBInspectable public var cornerRadius: CGFloat = CGFloat.nan {
    didSet {
      configCornerRadius()
    }
  }
  
  // MARK: - FillDesignable
  @IBInspectable public var fillColor: UIColor? {
    didSet {
      configFillColor()
    }
  }
  
  @IBInspectable public var predefinedColor: String? {
    didSet {
      configFillColor()
    }
  }
  
  @IBInspectable public var opacity: CGFloat = CGFloat.nan {
    didSet {
      configOpacity()
    }
  }
  
  // MARK: - BorderDesignable
  @IBInspectable public var borderColor: UIColor? {
    didSet {
      configBorder()
    }
  }
  
  @IBInspectable public var borderWidth: CGFloat = CGFloat.nan {
    didSet {
      configBorder()
    }
  }
  
  @IBInspectable public var borderSide: String? {
    didSet {
      configBorder()
    }
  }
  
  // MARK: - TableViewCellDesignable
  @IBInspectable public var removeSeparatorMargins: Bool = false
  
  // MARK: - GradientDesignable
  @IBInspectable public var startColor: UIColor?
  @IBInspectable public var endColor: UIColor?
  @IBInspectable public var predefinedGradient: String?
  @IBInspectable public var startPoint: String?
  
  // MARK: - Animatable
  @IBInspectable public var animationType: String?
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = Double.nan
  @IBInspectable public var delay: Double = Double.nan
  @IBInspectable public var damping: CGFloat = CGFloat.nan
  @IBInspectable public var velocity: CGFloat = CGFloat.nan
  @IBInspectable public var force: CGFloat = CGFloat.nan
  @IBInspectable public var repeatCount: Float = Float.nan
  @IBInspectable public var x: CGFloat = CGFloat.nan
  @IBInspectable public var y: CGFloat = CGFloat.nan
  
  // MARK: - Lifecycle
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configInspectableProperties()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    configInspectableProperties()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    configAfterLayoutSubviews()
    autoRunAnimation()
  }
  
  // MARK: - Private
  private func configInspectableProperties() {
    configAnimatableProperties()
    configOpacity()
  }
  
  private func configAfterLayoutSubviews() {
    configBorder()
    configGradient()
  }
}
