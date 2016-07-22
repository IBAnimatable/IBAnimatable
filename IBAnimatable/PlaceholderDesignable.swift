//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol PlaceholderDesignable {
  /**
   `color` within `::-webkit-input-placeholder`, `::-moz-placeholder` or `:-ms-input-placeholder`
   */
  var placeholderColor: UIColor? { get set }
  var placeholderText: String? { get set }
}

public extension PlaceholderDesignable where Self: UITextField {

  var placeholderText: String? { get { return "" } set {} }

  public func configPlaceholderColor() {
    if let unwrappedPlaceholderColor = placeholderColor {
      attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName: unwrappedPlaceholderColor])
    }
  }
}

public extension PlaceholderDesignable where Self: UITextView {

  public func configPlaceholderLabel(placeholderLabel: UILabel, inout placeholderLabelConstraints: [NSLayoutConstraint]) {
    placeholderLabel.font = font
    placeholderLabel.textColor = placeholderColor
    placeholderLabel.textAlignment = textAlignment
    placeholderLabel.text = placeholderText
    placeholderLabel.numberOfLines = 0
    placeholderLabel.backgroundColor = .clearColor()
    placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(placeholderLabel)
    updateConstraintsForPlaceholderLabel(placeholderLabel, placeholderLabelConstraints: &placeholderLabelConstraints)
  }

  public func updateConstraintsForPlaceholderLabel(placeholderLabel: UILabel, inout placeholderLabelConstraints: [NSLayoutConstraint]) {
    var newConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
                                                                        options: [], metrics: nil,
                                                                        views: ["placeholder": placeholderLabel])
    newConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(\(textContainerInset.top))-[placeholder]",
                                                                     options: [], metrics: nil,
                                                                     views: ["placeholder": placeholderLabel])
    newConstraints.append(NSLayoutConstraint(item: placeholderLabel,
      attribute: .Width,
      relatedBy: .Equal,
      toItem: self,
      attribute: .Width,
      multiplier: 1.0,
      constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)))
    removeConstraints(placeholderLabelConstraints)
    addConstraints(newConstraints)
    placeholderLabelConstraints = newConstraints
  }

}
