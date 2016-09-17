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
view.squeezeFade(.in, direction: .down) {
    view.pop(repeatCount: 1) {
        view.shake(repeatCount: 1) {
            view.squeeze(repeatCount: 1) {
                view.wobble(repeatCount: 1) {
                    view.flip(axis: .x) {
                        view.flip(axis: .y) {
                            view.slideFade(.out, direction: .down)
                        }
                    }
                }
            }
        }
    }
}

//: To apply delay, we can specify the animationType and delay
//view.animationType = AnimationType.pop(repeatCount: 1)
//view.animate {
//  view.delay = 0.3
//  view.animationType = AnimationType.shake(repeatCount: 1)
//  view.animate()
//}

//: [Next](@next)
