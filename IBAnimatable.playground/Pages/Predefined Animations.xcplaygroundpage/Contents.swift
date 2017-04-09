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

//view.animate(.slide(way: .in, direction: .left))
//view.animate(.slide(way: .in, direction: .right))
//view.animate(.slide(way: .in, direction: .down))
//view.animate(.slide(way: .in, direction: .up))
//view.animate(.slide(way: .out, direction: .left))
//view.animate(.slide(way: .out, direction: .right))
//view.animate(.slide(way: .out, direction: .down))
//view.animate(.slide(way: .out, direction: .up))

//view.animate(.squeeze(way: .in, direction: .left))
//view.animate(.squeeze(way: .in, direction: .right))
//view.animate(.squeeze(way: .in, direction: .down))
//view.animate(.squeeze(way: .in, direction: .up))
//view.animate(.squeeze(way: .out, direction: .left))
//view.animate(.squeeze(way: .out, direction: .right))
//view.animate(.squeeze(way: .out, direction: .down))
//view.animate(.squeeze(way: .out, direction: .up))

//view.animate(.fade(way: .in))
//view.animate(.fade(way: .out))
//view.animate(.fade(way: .inOut))
//view.animate(.fade(way: .outIn))

//view.animate(.slideFade(way: .in, direction: .left))
//view.animate(.slideFade(way: .in, direction: .right))
//view.animate(.slideFade(way: .in, direction: .down))
//view.animate(.slideFade(way: .in, direction: .up))
//view.animate(.slideFade(way: .out, direction: .left))
//view.animate(.slideFade(way: .out, direction: .right))
//view.animate(.slideFade(way: .out, direction: .down))
//view.animate(.slideFade(way: .out, direction: .up))

//view.animate(.squeezeFade(way: .in, direction: .left))
//view.animate(.squeezeFade(way: .in, direction: .right))
//view.animate(.squeezeFade(way: .in, direction: .down))
//view.animate(.squeezeFade(way: .in, direction: .up))
//view.animate(.squeezeFade(way: .out, direction: .left))
//view.animate(.squeezeFade(way: .out, direction: .right))
//view.animate(.squeezeFade(way: .out, direction: .down))
//view.animate(.squeezeFade(way: .out, direction: .up))

//view.animate(.zoom(way: .in))
//view.animate(.zoom(way: .out))
//view.animate(.zoomInvert(way: .in))
//view.animate(.zoomInvert(way: .out))

//view.animate(.shake(repeatCount: 1))
//view.animate(.pop(repeatCount: 1))
//view.animate(.morph(repeatCount: 1))
//view.animate(.squash(repeatCount: 1))
//view.animate(.flash(repeatCount: 1))
//view.animate(.wobble(repeatCount: 1))
//view.maskType = .none
//view.animate(.swing(repeatCount: 1))

//view.animate(.flip(along: .x))
//view.animate(.flip(along: .y))

view.maskType = .none
view.animate(.rotate(direction: .ccw, repeatCount: 10))
//view.animate(.rotate(direction: .cw, repeatCount: 10))

//view.animate(.moveTo(x: 100, y: 100))
//view.animate(.moveBy(x: 100, y: 100))

//: [Next](@next)
