//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable open class AnimatableTextView: UITextView, CornerDesignable, FillDesignable, BorderDesignable, Animatable, PlaceholderDesignable {
  
  // MARK: - CornerDesignable
  @IBInspectable open var cornerRadius: CGFloat = CGFloat.nan {
    didSet {
      configCornerRadius()
    }
  }
  
  // MARK: - FillDesignable
  @IBInspectable open var fillColor: UIColor? {
    didSet {
      configFillColor()
    }
  }
  
  @IBInspectable open var predefinedColor: String? {
    didSet {
      configFillColor()
    }
  }
  
  @IBInspectable open var opacity: CGFloat = CGFloat.nan {
    didSet {
      configOpacity()
    }
  }

  // MARK: - BorderDesignable
  @IBInspectable open var borderColor: UIColor? {
    didSet {
      configBorder()
    }
  }
  
  @IBInspectable open var borderWidth: CGFloat = CGFloat.nan {
    didSet {
      configBorder()
    }
  }
  
  open var borderSides: BorderSides  = .AllSides {
    didSet {
      configBorder()
    }
  }
  
  @IBInspectable var _borderSides: String? {
    didSet {
      borderSides = BorderSides(rawValue: _borderSides)
    }
  }
  // MARK: - PlaceholderDesignable
  @IBInspectable open var placeholderText: String? {
    didSet {
      placeholderLabel.text = placeholderText
    }
  }

  @IBInspectable open var placeholderColor: UIColor? {
    didSet {
      placeholderLabel.textColor = placeholderColor
    }
  }

  // MARK: - Animatable
open var animationType: AnimationType = .none
@IBInspectable  var _animationType: String? {
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
  @IBInspectable open var repeatCount: Float = Float.nan
 
  // MARK: Override properties
  override open var font: UIFont! {
    didSet {
      placeholderLabel.font = font
    }
  }

  override open var textAlignment: NSTextAlignment {
    didSet {
      placeholderLabel.textAlignment = textAlignment
    }
  }

  open override var text: String! {
    didSet {
      textDidChange()
    }
  }

  override open var attributedText: NSAttributedString! {
    didSet {
      textDidChange()
    }
  }

  override open var textContainerInset: UIEdgeInsets {
    didSet {
      update(placeholderLabel, using: &placeholderLabelConstraints)
    }
  }

  // MARK: Private properties
  fileprivate let placeholderLabel: UILabel = UILabel()
  fileprivate var placeholderLabelConstraints = [NSLayoutConstraint]()

  // MARK: - Lifecycle
  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    configInspectableProperties()
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    configInspectableProperties()
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    configAfterLayoutSubviews()
    autoRunAnimation()
  }

  deinit {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidChange, object: nil)
  }
  
  // MARK: - Private
  private func configInspectableProperties() {
    configAnimatableProperties()
    config(placeholder: placeholderLabel, placeholderLabelConstraints: &placeholderLabelConstraints)
    NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
  }

  @objc private func textDidChange() {
    placeholderLabel.isHidden = !text.isEmpty
  }

  private func configAfterLayoutSubviews() {
    configBorder()
    placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
  }
}
