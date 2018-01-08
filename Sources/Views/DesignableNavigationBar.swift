//
//  Created by Jake Lin on 12/10/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable
open class DesignableNavigationBar: UINavigationBar, NavigationBarDesignable, GradientDesignable {

  // MARK: - NavigationBarDesignable
  @IBInspectable open var solidColor: Bool = false

  // MARK: - GradientDesignable
  open var gradientMode: GradientMode = .linear
  @IBInspectable var _gradientMode: String? {
    didSet {
      gradientMode = GradientMode(string: _gradientMode) ?? .linear
    }
  }
  @IBInspectable open var startColor: UIColor?
  @IBInspectable open var endColor: UIColor?
  open var predefinedGradient: GradientType?
  @IBInspectable var _predefinedGradient: String? {
    didSet {
      predefinedGradient = GradientType(string: _predefinedGradient)
    }
  }
  open var startPoint: GradientStartPoint = .top
  @IBInspectable var _startPoint: String? {
    didSet {
      startPoint = GradientStartPoint(string: _startPoint, default: .top)
    }
  }

  // MARK: - Lifecycle
  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configureInspectableProperties()
  }

  open override func awakeFromNib() {
    super.awakeFromNib()
    configureInspectableProperties()
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    configureAfterLayoutSubviews()
  }

  // MARK: - Private
  fileprivate func configureInspectableProperties() {
    configureNavigationBar()
    configureGradient()
  }

  fileprivate func configureAfterLayoutSubviews() {
    configureGradient()
  }

}
