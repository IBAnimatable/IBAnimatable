//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallTrianglePath: ActivityIndicatorAnimating {

  // MARK: Properties

  fileprivate let duration: CFTimeInterval = 2
  fileprivate let timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

  // MARK: ActivityIndicatorAnimating

  public func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSize = size.width / 5
    let deltaX = size.width / 2 - circleSize / 2
    let deltaY = size.height / 2 - circleSize / 2
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let animation = defaultAnimation

    let topCenterCircle = ActivityIndicatorShape.ring.makeLayer(size: CGSize(width: circleSize, height: circleSize), color: color)
    change(animation: animation, values: ["{0,0}", "{hx,fy}", "{-hx,fy}", "{0,0}"], deltaX: deltaX, deltaY: deltaY)
    topCenterCircle.frame = CGRect(x: x + size.width / 2 - circleSize / 2, y: y, width: circleSize, height: circleSize)
    topCenterCircle.add(animation, forKey: "animation")
    layer.addSublayer(topCenterCircle)

    let bottomLeftCircle = ActivityIndicatorShape.ring.makeLayer(size: CGSize(width: circleSize, height: circleSize), color: color)
    change(animation: animation, values: ["{0,0}", "{hx,-fy}", "{fx,0}", "{0,0}"], deltaX: deltaX, deltaY: deltaY)
    bottomLeftCircle.frame = CGRect(x: x, y: y + size.height - circleSize, width: circleSize, height: circleSize)
    bottomLeftCircle.add(animation, forKey: "animation")
    layer.addSublayer(bottomLeftCircle)

    let bottomRightCircle = ActivityIndicatorShape.ring.makeLayer(size: CGSize(width: circleSize, height: circleSize), color: color)
    change(animation: animation, values: ["{0,0}", "{-fx,0}", "{-hx,-fy}", "{0,0}"], deltaX: deltaX, deltaY: deltaY)
    bottomRightCircle.frame = CGRect(x: x + size.width - circleSize, y: y + size.height - circleSize, width: circleSize, height: circleSize)
    bottomRightCircle.add(animation, forKey: "animation")
    layer.addSublayer(bottomRightCircle)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallTrianglePath {

  var defaultAnimation: CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath: .transform)
    animation.keyTimes = [0, 0.33, 0.66, 1]
    animation.timingFunctions = [timingFunction, timingFunction, timingFunction]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.isRemovedOnCompletion = false
    return animation
  }

  func change(animation: CAKeyframeAnimation, values rawValues: [String], deltaX: CGFloat, deltaY: CGFloat) {
    let values = NSMutableArray(capacity: 5)
    for rawValue in rawValues {
      let point = NSCoder.cgPoint(for: translateString(valueString: rawValue, deltaX: deltaX, deltaY: deltaY))
      values.add(NSValue(caTransform3D: CATransform3DMakeTranslation(point.x, point.y, 0)))
    }
    animation.values = values as [AnyObject]
  }

  func translateString(valueString: String, deltaX: CGFloat, deltaY: CGFloat) -> String {
    let valueMutableString = NSMutableString(string: valueString)
    let fullDeltaX = 2 * deltaX
    let fullDeltaY = 2 * deltaY
    var range = NSRange(location: 0, length: valueMutableString.length)
    valueMutableString.replaceOccurrences(of: "hx", with: "\(deltaX)", options: .caseInsensitive, range: range)
    range.length = valueMutableString.length
    valueMutableString.replaceOccurrences(of: "fx", with: "\(fullDeltaX)", options: .caseInsensitive, range: range)
    range.length = valueMutableString.length
    valueMutableString.replaceOccurrences(of: "hy", with: "\(deltaY)", options: .caseInsensitive, range: range)
    range.length = valueMutableString.length
    valueMutableString.replaceOccurrences(of: "fy", with: "\(fullDeltaY)", options: .caseInsensitive, range: range)
    return valueMutableString as String
  }

}
