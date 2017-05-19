//
//  Created by Tom Baranes on 23/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationAudioEqualizer: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate var size: CGSize = .zero
  fileprivate var lineSize: CGFloat = 0

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    self.size = size
    lineSize = size.width / 9
    let x = (layer.bounds.size.width - lineSize * 7) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let duration: [CFTimeInterval] = [4.3, 2.5, 1.7, 3.1]
    let values = [0, 0.7, 0.4, 0.05, 0.95, 0.3, 0.9, 0.4, 0.15, 0.18, 0.75, 0.01]

    // Draw lines
    for i in 0 ..< 4 {
      let animation = makeAnimation(duration: duration[i], values: values)
      let line = ActivityIndicatorShape.line.makeLayer(size: CGSize(width: lineSize, height: size.height), color: color)
      let frame = CGRect(x: x + lineSize * 2 * CGFloat(i),
                         y: y,
                         width: lineSize,
                         height: size.height)
      line.frame = frame
      line.add(animation, forKey: "animation")
      layer.addSublayer(line)
    }
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationAudioEqualizer {

  func makeAnimation(duration: CFTimeInterval, values: [Double]) -> CAKeyframeAnimation {
    let animation = CAKeyframeAnimation()
    animation.keyPath = "path"
    animation.isAdditive = true
    animation.values = []

    for j in 0..<values.count {
      let heightFactor = values[j]
      let height = size.height * CGFloat(heightFactor)
      let point = CGPoint(x: 0, y: size.height - height)
      let path = UIBezierPath(rect: CGRect(origin: point, size: CGSize(width: lineSize, height: height)))
      animation.values?.append(path.cgPath)
    }

    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

}
