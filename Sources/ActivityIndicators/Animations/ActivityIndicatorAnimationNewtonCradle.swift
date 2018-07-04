//
//  ActivityIndicatorAnimationNewtonCradle.swift
//  IBAnimatable
//
//  Created by phimage on 29/06/2018.
//  Copyright © 2018 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationNewtonCradle: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 0.4
  fileprivate let ratio: CGFloat = 7
  fileprivate let ballCount: Int = 5
  fileprivate let timingFunction: TimingFunctionType = .easeOutQuad

  fileprivate var ballSize: CGFloat = 0

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    ballSize = size.height / ratio
    var xPos = (size.width - (CGFloat(ballCount) * ballSize)) / 2
    let yPos = size.height - ballSize / 2

    var balls: [CALayer] = []
    for _ in 0 ..< ballCount {
      let ball = ActivityIndicatorShape.circle.makeLayer(size: CGSize(width: ballSize, height: ballSize), color: color)
      ball.frame = CGRect(x: xPos, y: yPos, width: ballSize, height: ballSize)
      balls.append(ball)
      xPos += ballSize
    }

    let firstBall = balls.removeFirst()
    firstBall.add(makeAnimation(for: firstBall, in: layer, size: size, reverse: true), forKey: "animation")
    layer.addSublayer(firstBall)

    let lastBall = balls.removeLast()
    lastBall.add(makeAnimation(for: lastBall, in: layer, size: size, reverse: false), forKey: "animation")
    layer.addSublayer(lastBall)

    for ball in balls {
      layer.addSublayer(ball)
    }
  }
}

private extension ActivityIndicatorAnimationNewtonCradle {

  func makeAnimation(for ball: CALayer, in layer: CALayer, size: CGSize, reverse: Bool) -> CAAnimation {
    let rotateAnimation = CAKeyframeAnimation(keyPath: .position)
    rotateAnimation.path = UIBezierPath(arcCenter: CGPoint(x: ball.frame.origin.x + ballSize / 2, y: size.height / 2),
                                        radius: size.height / 2,
                                        startAngle: CGFloat.pi / 2,
                                        endAngle: reverse ? CGFloat.pi: 0,
                                        clockwise: reverse).cgPath
    rotateAnimation.duration = duration
    rotateAnimation.autoreverses = true
    rotateAnimation.timingFunctionType = timingFunction

    if reverse {
      rotateAnimation.beginTime = duration * 2
    }

    let animation = CAAnimationGroup()
    animation.animations = [rotateAnimation]
    animation.duration = duration * 4
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }
}
