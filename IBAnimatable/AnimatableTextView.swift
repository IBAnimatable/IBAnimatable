//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableTextView: UITextView, CornerDesignable, FillDesignable, BorderDesignable, Animatable, PlaceholderDesignable {
  
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

  // MARK: - PlaceholderDesignable
  @IBInspectable public var placeholderText: String? {
    didSet {
      placeholderLabel.text = placeholderText
    }
  }

  @IBInspectable public var placeholderColor: UIColor? {
    didSet {
      placeholderLabel.textColor = placeholderColor
    }
  }

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

  // MARK: Override properties
  override public var font: UIFont! {
    didSet {
      placeholderLabel.font = font
    }
  }

  override public var textAlignment: NSTextAlignment {
    didSet {
      placeholderLabel.textAlignment = textAlignment
    }
  }

  public override var text: String! {
    didSet {
      textDidChange()
    }
  }

  override public var attributedText: AttributedString! {
    didSet {
      textDidChange()
    }
  }

  override public var textContainerInset: UIEdgeInsets {
    didSet {
      update(constraints: &placeholderLabelConstraints, for: placeholderLabel)
    }
  }

  // MARK: Private properties
  private let placeholderLabel: UILabel = UILabel()
  private var placeholderLabelConstraints = [NSLayoutConstraint]()

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

  deinit {
    NotificationCenter.default().removeObserver(self, name: NSNotification.Name.UITextViewTextDidChange, object: nil)
  }
  
  // MARK: - Private
  private func configInspectableProperties() {
    configAnimatableProperties()
    config(placeholderLabel: placeholderLabel, placeholderLabelConstraints: &placeholderLabelConstraints)
    NotificationCenter.default().addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
  }

  @objc private func textDidChange() {
    placeholderLabel.isHidden = !text.isEmpty
  }

  private func configAfterLayoutSubviews() {
    configBorder()
    placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0

  }
}
