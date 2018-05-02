//
//  ActivityIndicatorAnimationGear.swift
//  IBAnimatable
//
//  Created by phimage on 02/05/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationGear: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 3

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let radius = layer.bounds.size.width / 10
    let mask: MaskType = .gear(radius: Double(radius), cogs: 8)
    let circle = ActivityIndicatorShape.mask(type: mask).makeLayer(size: size, color: color)
    circle.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
    circle.add(defaultAnimation, forKey: "animation")
    layer.addSublayer(circle)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationGear {

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
