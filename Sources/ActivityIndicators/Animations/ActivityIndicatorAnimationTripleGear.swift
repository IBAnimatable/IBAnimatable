//
//  ActivityIndicatorAnimationTripleGear.swift
//  IBAnimatable
//
//  Created by phimage on 04/05/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationTripleGear: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 3

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let x = (layer.bounds.size.width - size.width) / 2 + size.width / 8
    let y = (layer.bounds.size.height - size.height) / 2 + size.height / 8

    let mask: MaskType = .gear(radius: Double(layer.bounds.size.width / 20), cogs: 8)
    let gear = ActivityIndicatorShape.mask(type: mask).makeLayer(size: size / 2, color: color)
    gear.frame = CGRect(x: x, y: y, width: size.width / 2, height: size.height / 2)
    let animation = defaultAnimation
    animation.byValue = -Float.pi * 2
    gear.add(animation, forKey: "animation")
    layer.addSublayer(gear)

    let mask2: MaskType = .gear(radius: Double(layer.bounds.size.width / 30), cogs: 8)
    let gear2 = ActivityIndicatorShape.mask(type: mask2).makeLayer(size: size / 3, color: color)
    gear2.frame = CGRect(x: x + size.width / 4, y: y + size.height / 2, width: size.width / 3, height: size.height / 3)
    gear2.add(defaultAnimation, forKey: "animation")
    layer.addSublayer(gear2)

    let mask3: MaskType = .gear(radius: Double(layer.bounds.size.width / 40), cogs: 8)
    let gear3 = ActivityIndicatorShape.mask(type: mask3).makeLayer(size: size / 4, color: color)
    gear3.frame = CGRect(x: x + size.width / 2, y: y + size.height / 4, width: size.width / 4, height: size.height / 4)
    gear3.add(defaultAnimation, forKey: "animation")
    layer.addSublayer(gear3)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationTripleGear {

  var defaultAnimation: CABasicAnimation {
    let rotationAnimation = CABasicAnimation(keyPath: .rotation)
    rotationAnimation.byValue = Float.pi * 2
    rotationAnimation.timingFunctionType = .linear
    rotationAnimation.duration = duration
    rotationAnimation.repeatCount = .infinity
    rotationAnimation.isRemovedOnCompletion = false
    return rotationAnimation
  }

}

private extension CGSize {
  static func / (size: CGSize, by: CGFloat) -> CGSize {
    return CGSize(width: size.width / by, height: size.height / by)
  }
}
