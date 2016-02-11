//
//  Created by Jake Lin on 12/2/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class DesignableGradientView: UIView, GradientDesignable, CornerDesignable {

  // MARK: - GradientDesignable
  @IBInspectable public var startColor: UIColor?
  @IBInspectable public var endColor: UIColor?
  @IBInspectable public var predefinedGradient: String?
  @IBInspectable public var startPoint: String?
  
  // MARK: - CornerDesignable
  @IBInspectable public var cornerRadius: CGFloat = CGFloat.NaN {
    didSet {
      configCornerRadius()
    }
  }
  
  // MARK: - Lifecycle
  public override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configInspectableProperties()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    configInspectableProperties()
  }
  
  // MARK: - Private
  private func configInspectableProperties() {
    configGradient()
//    configGradientWithLayer(gradientLayer)
  }

}
