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
view.configAnimatableProperties()
iPhoneView.addSubview(view)

view.fillColor = UIColor(red: 0xba/0xff, green: 0x77/0xff, blue: 1, alpha: 1)
view.maskType = "Circle"

//: animationType: all supported predefined animations can be found in `enum AnimationType`
view.animationType = "SqueezeInLeft"

//: duration: used to specify the duration of animation. Default value is 0.7
view.duration = 0.8

//: delay: used to delay the animation in seconds. Default value is 0
view.delay = 0.5

//: damping: used in UIView Spring animation (0 ~ 1). To smoothly decelerate the animation without oscillation, use a value of 1. Employ a damping ratio closer to zero to increase oscillation. Default is 0.7. Notice: FadeOutIn, FadeInOut, Shake, Pop, Morph, Squeeze, Flash, Wobble and Swing animations do not use damping.
view.damping = 0.5

//: velocity: used in UIView Spring animation. A value of 1 corresponds to the total animation distance traversed in one second. For example, if the total animation distance is 200 points and you want the start of the animation to match a view velocity of 100 pt/s, use a value of 0.5. Default is 0.7. Notice: FadeOutIn, FadeInOut, Shake, Pop, Morph, Squeeze, Flash, Wobble and Swing animations do not use damping.
view.velocity = 2

//: force: used to apply force to the animation. The number is higher, the animation property has more changes. eg. for Pop animation, higher force causes the view poping bigger. Default is 1
view.force = 1

//: repeatCount: used to sepecify the count to repeat the animation. Can noly used in Shake, Pop, Morph, Squeeze, Flash, Wobble, Swing and Rotate animations
view.repeatCount = 5

view.animate()

//: [Next](@next)
