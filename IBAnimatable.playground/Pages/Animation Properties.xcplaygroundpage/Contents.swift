//: [Previous](@previous)

//: ## Animation Properties


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

//: animationType: all supported predefined animations can be found in `enum AnimationType`
view.animationType = "SqueezeInLeft"
//: delay: used to delay the animation in seconds. Default is 0
view.delay = 0.5
//: force: used to apply force to the animation. The number is higher, the animation property has more changes. eg. for Pop animation, higher force causes the view poping bigger. Default is 1
view.force = 2
//: damping: used in UIView Spring animation. Default is 0.7. Notice: FadeOutIn, FadeInOut, Shake, Pop, Morph, Squeeze, Flash, Wobble and Swing animations do not use damping.
view.damping = 1


view.animate()

//: [Next](@next)
