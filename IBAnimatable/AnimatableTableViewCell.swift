//
//  Created by Jake Lin on 12/16/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableTableViewCell: UITableViewCell, FillDesignable, BorderDesignable, TableViewCellDesignable, Animatable {
  
  // MARK: - FillDesignable
  @IBInspectable public var fillColor: UIColor?
  @IBInspectable public var opacity: CGFloat = CGFloat.NaN
  
  // MARK: - BorderDesignable
  @IBInspectable public var borderColor: UIColor?
  @IBInspectable public var borderWidth: CGFloat = CGFloat.NaN
  @IBInspectable public var borderSide: String?
  
  @IBInspectable public var removeSeparatorMargins: Bool = false
  
  // MARK: - Animatable
  @IBInspectable public var animationType: String?
  @IBInspectable public var autoRun: Bool = true
  @IBInspectable public var duration: Double = Double.NaN
  @IBInspectable public var delay: Double = Double.NaN
  @IBInspectable public var damping: CGFloat = CGFloat.NaN
  @IBInspectable public var velocity: CGFloat = CGFloat.NaN
  @IBInspectable public var force: CGFloat = CGFloat.NaN
  @IBInspectable public var repeatCount: Float = Float.NaN
  
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
    
    autoRunAnimation()
  }
  
  // MARK: - Private
  private func configInspectableProperties() {
    configAnimatableProperites()
    configFillColor()
    configOpacity()
    configBorder()
    configSeparatorMargins()
  }
}