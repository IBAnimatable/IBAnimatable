//
//  ActivityIndicatorAnimationCirclePendulum.swift
//  IBAnimatable
//
//  Created by phimage on 29/06/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import Foundation

import UIKit

public class ActivityIndicatorAnimationCirclePendulum: ActivityIndicatorAnimating {

  // MARK: Properties

  public var duration: CFTimeInterval = 0.8
  fileprivate let ratio: CGFloat = 7
  fileprivate let ballCount: Int = 3

  #if LG
  public var primaryColor = true
  #else
  public var primaryColor = false
  #endif
  fileprivate let colors: [UIColor] = [.magenta, .yellow, .cyan]

  fileprivate var ballSize: CGFloat = 0

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    ballSize = size.height / ratio
    var xPos = (size.width - (CGFloat(ballCount) * ballSize)) / 2
    let yPos = size.height - ballSize / 2

    for i in 0 ..< ballCount {
      let ball = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: ballSize, height: ballSize), color: primaryColor ? colors[i]: color)
      ball.frame = CGRect(x: xPos, y: yPos, width: ballSize, height: ballSize)
      ball.add(makeAnimation(for: ball, in: layer, size: size, pos: i), forKey: "animation")
      layer.addSublayer(ball)
      xPos += ballSize
    }
  }
}

private extension ActivityIndicatorAnimationCirclePendulum {

  func makeAnimation(for ball: CALayer, in layer: CALayer, size: CGSize, pos: Int) -> CAAnimation {
    let angle = 2 * atan(ballSize / (size.height - ballSize / 2))

    var animations: [CAKeyframeAnimation] = [] // only 3 balls, code not generic yet, how to compute angles?

    let rotateAnimation = CAKeyframeAnimation(keyPath: .position)
    var animPos = 0
    rotateAnimation.path = UIBezierPath(arcCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                                        radius: size.height / 2,
                                        startAngle: CGFloat.pi / 2 + angle,
                                        endAngle: 2 * CGFloat.pi + CGFloat.pi / 2 - angle,
                                        clockwise: true).cgPath
    rotateAnimation.duration = duration
    rotateAnimation.timingFunctionType = .easeInOut
    rotateAnimation.beginTime = duration * CFTimeInterval((pos + animPos) % ballCount)
    animations.append(rotateAnimation)

    let rotateAnimation2 = CAKeyframeAnimation(keyPath: .position)
    animPos += 1
    rotateAnimation2.path = UIBezierPath(arcCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                                         radius: size.height / 2,
                                         startAngle: 2 * CGFloat.pi + CGFloat.pi / 2 - angle,
                                         endAngle: 2 * CGFloat.pi + CGFloat.pi / 2,
                                         clockwise: true).cgPath
    rotateAnimation2.duration = duration
    rotateAnimation2.timingFunctionType = .easeOutExpo
    rotateAnimation2.beginTime = duration * CFTimeInterval((pos + animPos) % ballCount)
    animations.append(rotateAnimation2)

    let rotateAnimation3 = CAKeyframeAnimation(keyPath: .position)
    animPos += 1
    rotateAnimation3.path = UIBezierPath(arcCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                                         radius: size.height / 2,
                                         startAngle: 2 * CGFloat.pi + CGFloat.pi / 2,
                                         endAngle: 2 * CGFloat.pi + CGFloat.pi / 2 + angle,
                                         clockwise: true).cgPath
    rotateAnimation3.duration = duration
    rotateAnimation3.timingFunctionType = .easeOutExpo
    rotateAnimation3.beginTime = duration * CFTimeInterval((pos + animPos) % ballCount)
    animations.append(rotateAnimation3)

    let animation = CAAnimationGroup()
    animation.animations = animations
    animation.duration = duration * CFTimeInterval(ballCount)
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }
}
