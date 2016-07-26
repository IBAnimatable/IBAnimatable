//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableTextView: UITextView, CornerDesignable, FillDesignable, BorderDesignable, Animatable, PlaceholderDesignable {
  
  // MARK: - CornerDesignable
  @IBInspectable public var cornerRadius: CGFloat = CGFloat.NaN {
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
  
  @IBInspectable public var opacity: CGFloat = CGFloat.NaN {
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
  
  @IBInspectable public var borderWidth: CGFloat = CGFloat.NaN {
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
  @IBInspectable public var duration: Double = Double.NaN
  @IBInspectable public var delay: Double = Double.NaN
  @IBInspectable public var damping: CGFloat = CGFloat.NaN
  @IBInspectable public var velocity: CGFloat = CGFloat.NaN
  @IBInspectable public var force: CGFloat = CGFloat.NaN
  @IBInspectable public var repeatCount: Float = Float.NaN
  @IBInspectable public var x: CGFloat = CGFloat.NaN
  @IBInspectable public var y: CGFloat = CGFloat.NaN

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

  override public var attributedText: NSAttributedString! {
    didSet {
      textDidChange()
    }
  }

  override public var textContainerInset: UIEdgeInsets {
    didSet {
      updateConstraintsForPlaceholderLabel(placeholderLabel, placeholderLabelConstraints: &placeholderLabelConstraints)
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
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: nil)
  }
  
  // MARK: - Private
  private func configInspectableProperties() {
    configAnimatableProperties()
    configPlaceholderLabel(placeholderLabel, placeholderLabelConstraints: &placeholderLabelConstraints)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textDidChange), name: UITextViewTextDidChangeNotification, object: nil)
  }

  @objc private func textDidChange() {
    placeholderLabel.hidden = !text.isEmpty
  }

  private func configAfterLayoutSubviews() {
    configBorder()
    placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0

  }
}
