//
//  Created by David Jennes on 7/10/18.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

/// Note: this file has a `_` in the filename on purpose, to ensure it is the
/// first compiled file. See:
/// https://bugs.swift.org/browse/SR-631

/// Swift < 4.2 support
#if !(swift(>=4.2))
enum CAMediaTimingFunctionName {
	static let linear = kCAMediaTimingFunctionLinear
	static let easeIn = kCAMediaTimingFunctionEaseIn
	static let easeOut = kCAMediaTimingFunctionEaseOut
	static let easeInEaseOut = kCAMediaTimingFunctionEaseInEaseOut
	static let `default` = kCAMediaTimingFunctionDefault
}

enum CAMediaTimingFillMode {
	static let forwards = kCAFillModeForwards
}

enum CAShapeLayerFillRule {
	static let evenOdd = kCAFillRuleEvenOdd
}

enum CAShapeLayerLineCap {
	static let round = kCALineCapRound
}

enum CAShapeLayerLineJoin {
	static let round = kCALineJoinRound
}

public typealias CATransitionSubtype = String
extension CATransitionSubtype {
	static let fromBottom = kCATransitionFromBottom
	static let fromLeft = kCATransitionFromLeft
	static let fromRight = kCATransitionFromRight
	static let fromTop = kCATransitionFromTop
}

public extension CGRect {
    func inset(by insets: UIEdgeInsets) -> CGRect {
        return UIEdgeInsetsInsetRect(self, insets)
    }
}

extension NSCoder {
	class func cgPoint(for string: String) -> CGPoint {
		return CGPointFromString(string)
	}
}

public extension UIBlurEffect {
    typealias Style = UIBlurEffectStyle
}

extension UIControl {
	typealias State = UIControlState
}

public extension UINavigationController {
    typealias Operation = UINavigationControllerOperation
}

extension UIResponder {
	static let keyboardAnimationDurationUserInfoKey = UIKeyboardAnimationDurationUserInfoKey
	static let keyboardFrameEndUserInfoKey = UIKeyboardFrameEndUserInfoKey
	static let keyboardWillHideNotification = NSNotification.Name.UIKeyboardWillHide
	static let keyboardWillShowNotification = NSNotification.Name.UIKeyboardWillShow
}

extension UITextView {
	static let textDidChangeNotification = NSNotification.Name.UITextViewTextDidChange
}

extension UIView {
	typealias AnimationOptions = UIViewAnimationOptions

	func sendSubviewToBack(_ view: UIView) {
		sendSubview(toBack: view)
	}
	func bringSubviewToFront(_ view: UIView) {
		bringSubview(toFront: view)
	}
}

extension UIViewController {
	func willMove(toParent parent: UIViewController?) {
		willMove(toParentViewController: parent)
	}
	func didMove(toParent parent: UIViewController?) {
		didMove(toParentViewController: parent)
	}
	func addChild(_ childController: UIViewController) {
		addChildViewController(childController)
	}
	func removeFromParent() {
		removeFromParentViewController()
	}
}
#endif
