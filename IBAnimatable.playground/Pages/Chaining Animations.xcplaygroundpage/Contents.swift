//: [Previous](@previous)

//: ## Chaining Animations

import UIKit
import XCPlayground
import IBAnimatable

//: Constants
let iPhoneWidth = 375
let iPhoneHeight = 667
let animatableViewWidth = 100
let animatableViewX = (iPhoneWidth - animatableViewWidth) / 2
let animatableViewY = (iPhoneHeight - animatableViewWidth) / 2

//: Set up the iPhone View
let iPhoneView = UIView(frame: CGRect(x: 0, y: 0, width: iPhoneWidth, height: iPhoneHeight))
iPhoneView.backgroundColor = .whiteColor()
XCPlaygroundPage.currentPage.liveView = iPhoneView

//: Set up the animatable View
let view = AnimatableView(frame: CGRect(x: animatableViewX, y: animatableViewY, width: animatableViewWidth, height: animatableViewWidth))
iPhoneView.addSubview(view)

view.fillColor = UIColor(red: 0xba/0xff, green: 0x77/0xff, blue: 1, alpha: 1)
view.maskType = "Circle"

//: Start another animation in completion closure
view.squeezeInDown{ view.pop { view.shake{ view.squeeze{ view.wobble{ view.flipX { view.flash{ view.fadeOutDown() } } } } } } }

//: [Next](@next)
