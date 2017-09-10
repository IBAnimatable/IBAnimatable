//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol PlaceholderDesignable: class {
  /**
   `color` within `::-webkit-input-placeholder`, `::-moz-placeholder` or `:-ms-input-placeholder`
   */
  var placeholderColor: UIColor? { get set }
  var placeholderText: String? { get set }
}

public extension PlaceholderDesignable where Self: UITextField {

  var placeholderText: String? { get { return "" } set {} }

  public func configurePlaceholderColor() {
    let text = placeholder ?? placeholderText
    if let placeholderColor = placeholderColor, let placeholder = text {
      attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor])
    }
  }
}

public extension PlaceholderDesignable where Self: UITextView {

  public func configure(placeholderLabel: UILabel, placeholderLabelConstraints: inout [NSLayoutConstraint]) {
    placeholderLabel.font = font
    placeholderLabel.textColor = placeholderColor
    placeholderLabel.textAlignment = textAlignment
    placeholderLabel.text = placeholderText
    placeholderLabel.numberOfLines = 0
    placeholderLabel.backgroundColor = .clear
    placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(placeholderLabel)
    update(placeholderLabel, using: &placeholderLabelConstraints)
  }

  public func update(_ placeholderLabel: UILabel, using constraints: inout [NSLayoutConstraint]) {
    var format = "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]"
    var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: format,
                                                        options: [], metrics: nil,
                                                        views: ["placeholder": placeholderLabel])

    format = "V:|-(\(textContainerInset.top))-[placeholder]"
    newConstraints += NSLayoutConstraint.constraints(withVisualFormat: format,
                                                     options: [], metrics: nil,
                                                     views: ["placeholder": placeholderLabel])

    let constant = -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
    newConstraints.append(NSLayoutConstraint(item: placeholderLabel,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .width,
                                             multiplier: 1.0,
                                             constant: constant))

    removeConstraints(constraints)
    addConstraints(newConstraints)
    constraints = newConstraints
  }

}
