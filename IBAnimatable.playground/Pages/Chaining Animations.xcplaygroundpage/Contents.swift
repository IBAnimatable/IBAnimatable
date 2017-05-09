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

////: Chain your animations
view.animate(.squeezeFade(way: .in, direction: .down))
    .then(.pop(repeatCount: 1))
    .then(.shake(repeatCount: 1))
    .then(.squeeze(way: .in, direction: .down))
    .then(.wobble(repeatCount: 1))
    .then(.flip(along: .x))
    .then(.flip(along: .y))
    .then(.slideFade(way: .out, direction: .down))

//: To apply delay, we can specify the delay before doing specifying the animationType
view.animate(.pop(repeatCount: 1))
    .delay(0.3)
    .then(.shake(repeatCount: 1))

//: [Next](@next)
