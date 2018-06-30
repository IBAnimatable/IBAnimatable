//
//  ActivityIndicatorAnimationHeartBeat.swift
//  IBAnimatable
//
//  Created by phimage on 02/05/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationHeartBeat: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 0.8

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let circle = ActivityIndicatorShape.mask(type: .heart).makeLayer(size: size, color: color)
    circle.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
    circle.add(defaultAnimation, forKey: "animation")
    layer.addSublayer(circle)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationHeartBeat {

  var defaultAnimation: CABasicAnimation {
    let scaleAnimation = CABasicAnimation(keyPath: .scale)
    scaleAnimation.timingFunctionType = .easeOutBack
    scaleAnimation.duration = duration
    scaleAnimation.repeatCount = .infinity
    scaleAnimation.autoreverses = true
    scaleAnimation.fromValue = 1
    scaleAnimation.toValue = 0.8
    scaleAnimation.isRemovedOnCompletion = false
    return scaleAnimation
  }

}
