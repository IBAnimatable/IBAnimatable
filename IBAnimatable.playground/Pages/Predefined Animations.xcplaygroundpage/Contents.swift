//: ## Predefined Animations

import UIKit
import PlaygroundSupport
import IBAnimatable

let iPhoneView = PhoneView()
PlaygroundPage.current.liveView = iPhoneView

//: Set up the animatable View
let view = CircleView()
iPhoneView.addSubview(view)

//: Animations, all supported predefined animations can be found in `enum AnimationType`

// Uncomment one line to play the animation

//view.slide(.in, direction: .left)
//view.slide(.in, direction: .right)
//view.slide(.in, direction: .down)
//view.slide(.in, direction: .up)
//view.slide(.out, direction: .left)
//view.slide(.out, direction: .right)
//view.slide(.out, direction: .down)
//view.slide(.out, direction: .up)
//view.squeeze(.in, direction: .left)
//view.squeeze(.in, direction: .right)
//view.squeeze(.in, direction: .down)
//view.squeeze(.in, direction: .up)
//view.squeeze(.out, direction: .left)
//view.squeeze(.out, direction: .right)
//view.squeeze(.out, direction: .down)
//view.squeeze(.out, direction: .up)
//view.fade(.in)
//view.fade(.out)
//view.fade(.inOut)
//view.fade(.outIn)
//view.slideFade(.in, direction: .left)
//view.slideFade(.in, direction: .right)
//view.slideFade(.in, direction: .down)
//view.slideFade(.in, direction: .up)
//view.slideFade(.out, direction: .left)
//view.slideFade(.out, direction: .right)
//view.slideFade(.out, direction: .down)
//view.slideFade(.out, direction: .up)
//view.squeezeFade(.in, direction: .left)
//view.squeezeFade(.in, direction: .right)
//view.squeezeFade(.in, direction: .down)
//view.squeezeFade(.in, direction: .up)
//view.squeezeFade(.out, direction: .left)
//view.squeezeFade(.out, direction: .right)
//view.squeezeFade(.out, direction: .down)
//view.squeezeFade(.out, direction: .up)
//view.zoom(.in)
//view.zoom(.out)
//view.zoom(.in, invert: true)
view.zoom(.out, invert: true)
//view.shake(repeatCount: 1)
//view.pop(repeatCount: 1)
//view.flip(axis: .x)
//view.flip(axis: .y)
//view.morph(repeatCount: 1)
//view.squeeze(repeatCount: 1)
//view.flash(repeatCount: 1)
//view.wobble(repeatCount: 1)
//view.swing(repeatCount: 1)
//view.rotate(direction: .ccw, repeatCount: 10)
//view.rotate(direction: .cw, repeatCount: 10)
//view.moveTo(x: 100, y: 100)
//view.moveBy(x: 100, y: 100)

//: [Next](@next)
