//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableTextView: UITextView, CornerDesignable, FillDesignable, BorderDesignable, Animatable {

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
		placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
		autoRunAnimation()
	}

	// MARK: - Private
	private func configInspectableProperties() {
		configAnimatableProperties()
	}

	private func configAfterLayoutSubviews() {
		configBorder()
	}
	private struct Constants {
		static let defaultiOSPlaceholderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
	}
	public let placeholderLabel: UILabel = UILabel()

	private var placeholderLabelConstraints = [NSLayoutConstraint]()

	@IBInspectable public var placeholder: String = "" {
		didSet {
			placeholderLabel.text = placeholder
		}
	}

	@IBInspectable public var placeholderColor: UIColor = AnimatableTextView.Constants.defaultiOSPlaceholderColor {
		didSet {
			placeholderLabel.textColor = placeholderColor
		}
	}

	override public var font: UIFont! {
		didSet {
			if placeholderFont == nil {
				placeholderLabel.font = font
			}
		}
	}

	public var placeholderFont: UIFont? {
		didSet {
			let font = (placeholderFont != nil) ? placeholderFont : self.font
			placeholderLabel.font = font
		}
	}

	override public var textAlignment: NSTextAlignment {
		didSet {
			placeholderLabel.textAlignment = textAlignment
		}
	}

	override public var text: String! {
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
			updateConstraintsForPlaceholderLabel()
		}
	}

	override public init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		commonInit()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}

	private func commonInit() {
		NSNotificationCenter.defaultCenter().addObserver(self,
			selector: #selector(textDidChange),
			name: UITextViewTextDidChangeNotification,
			object: nil)

		placeholderLabel.font = font
		placeholderLabel.textColor = placeholderColor
		placeholderLabel.textAlignment = textAlignment
		placeholderLabel.text = placeholder
		placeholderLabel.numberOfLines = 0
		placeholderLabel.backgroundColor = UIColor.clearColor()
		placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(placeholderLabel)
		updateConstraintsForPlaceholderLabel()
	}

	private func updateConstraintsForPlaceholderLabel() {
		var newConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
			options: [],
			metrics: nil,
			views: ["placeholder": placeholderLabel])
		newConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(\(textContainerInset.top))-[placeholder]",
			options: [],
			metrics: nil,
			views: ["placeholder": placeholderLabel])
		newConstraints.append(NSLayoutConstraint(
			item: placeholderLabel,
			attribute: .Width,
			relatedBy: .Equal,
			toItem: self,
			attribute: .Width,
			multiplier: 1.0,
			constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
		))
		removeConstraints(placeholderLabelConstraints)
		addConstraints(newConstraints)
		placeholderLabelConstraints = newConstraints
	}

	@objc private func textDidChange() {
		placeholderLabel.hidden = !text.isEmpty
	}

	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self,
			name: UITextViewTextDidChangeNotification,
			object: nil)
	}
}
