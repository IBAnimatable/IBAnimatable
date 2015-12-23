//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import IBAnimatable

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
containerView.backgroundColor = .lightGrayColor()
XCPlaygroundPage.currentPage.liveView = containerView


let view = AnimatableView(frame: CGRectMake(100, 100, 50, 50))
containerView.addSubview(view)
view.fillColor = UIColor(red: 0xba, green: 0x77, blue: 0xff, alpha: 1)
view.maskType = "Circle"
view.slideInLeft()