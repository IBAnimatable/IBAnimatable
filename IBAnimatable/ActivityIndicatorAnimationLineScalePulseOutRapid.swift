//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationLineScalePulseOutRapid: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 0.9
  fileprivate let timingFunction = CAMediaTimingFunction(controlPoints: 0.11, 0.49, 0.38, 0.78)
  fileprivate let beginTime = CACurrentMediaTime()

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let lineSize = size.width / 9
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let beginTimes = [0.5, 0.25, 0, 0.25, 0.5]
    let animation = defaultAnimation
    for i in 0 ..< 5 {
      let line = ActivityIndicatorShape.line.makeLayer(size: CGSize(width: lineSize, height: size.height), color: color)
      let frame = CGRect(x: x + lineSize * 2 * CGFloat(i),
                         y: y,
                         width: lineSize,
                         height: size.height)

      animation.beginTime = beginTime + beginTimes[i]
      line.frame = frame
      line.add(animation, forKey: "animation")
      layer.addSublayer(line)
    }
  }
}

// MARK: - Setup

private extension ActivityIndicatorAnimationLineScalePulseOutRapid {

  var defaultAnimation: CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
    animation.keyTimes = [0, 0.8, 0.9]
    animation.timingFunctions = [timingFunction, timingFunction]
    animation.beginTime = beginTime
    animation.values = [1, 0.3, 1]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

}
