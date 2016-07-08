//: ## Predefined Animations

import UIKit
import PlaygroundSupport
import IBAnimatable

//: Constants
let iPhoneWidth = 375
let iPhoneHeight = 667
let animatableViewWidth = 100
let animatableViewX = (iPhoneWidth - animatableViewWidth) / 2
let animatableViewY = (iPhoneHeight - animatableViewWidth) / 2

//: Set up the iPhone View
let iPhoneView = UIView(frame: CGRect(x: 0, y: 0, width: iPhoneWidth, height: iPhoneHeight))
iPhoneView.backgroundColor = .white()
PlaygroundPage.current.liveView = iPhoneView


////: Set up the animatable View
let view = AnimatableView(frame: CGRect(x: animatableViewX, y: animatableViewY, width: animatableViewWidth, height: animatableViewWidth))
view.configAnimatableProperties()
iPhoneView.addSubview(view)

view.fillColor = #colorLiteral(red: 0.7098039216, green: 0.4549019608, blue: 0.9607843137, alpha: 1)
view.borderWidth = 2
view.borderColor = .purple()
view.maskType = .circle


// For `moveTo` or `moveBy` animation
view.x = -100
view.y = 200

//: Animations, all supported predefined animations can be found in `enum AnimationType`  

// Uncomment one line to play the animation

//view.slideInLeft()
//view.slideInRight()
//view.slideInDown()
//view.slideInUp()
//view.slideOutLeft()
//view.slideOutRight()
//view.slideOutDown()
//view.slideOutUp()
//view.squeezeInLeft()
//view.squeezeInRight()
//view.squeezeInDown()
//view.squeezeInUp()
//view.squeezeOutLeft()
//view.squeezeOutRight()
//view.squeezeOutDown()
//view.squeezeOutUp()
//view.fadeIn()
//view.fadeOut()
//view.fadeOutIn()
//view.fadeInOut()
//view.fadeInLeft()
//view.fadeInRight()
//view.fadeInDown()
//view.fadeInUp()
//view.fadeOutLeft()
//view.fadeOutRight()
//view.fadeOutDown()
//view.fadeOutUp()
//view.squeezeFadeInLeft()
//view.squeezeFadeInRight()
//view.squeezeFadeInDown()
//view.squeezeFadeInUp()
//view.squeezeFadeOutLeft()
//view.squeezeFadeOutRight()
//view.squeezeFadeOutDown()
//view.squeezeFadeOutUp()
//view.zoomIn()
//view.zoomOut()
//view.shake()
view.pop()
//view.flipX()
//view.flipY()
//view.morph()
//view.squeeze()
//view.flash()
//view.wobble()
//view.swing()
//view.rotate()
//view.rotate(clockwise: false)
//view.moveTo()
//view.moveBy()

//: [Next](@next)
