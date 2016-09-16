//: [Previous](@previous)

//: ## Chaining Animations

import UIKit
import PlaygroundSupport
import IBAnimatable

//: Set up the iPhone View
let iPhoneView = PhoneView()
PlaygroundPage.current.liveView = iPhoneView

//: Set up the animatable View
let view = CircleView()
iPhoneView.addSubview(view)

////: Start another animation in completion closure
view.squeezeInDown { view.pop { view.shake { view.squeeze { view.wobble { view.flipX { view.flash { view.flipY { view.fadeOutDown() } } } } } } } }

//: To apply delay, we can specify the animationType and delay
//view.animationType = String(AnimationType.pop)
//view.animate{
//  view.delay = 0.3
//  view.animationType = String(AnimationType.shake)
//  view.animate()
//}

//: [Next](@next)
