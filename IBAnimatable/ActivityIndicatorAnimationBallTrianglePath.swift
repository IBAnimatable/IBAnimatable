//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallTrianglePath: ActivityIndicatorAnimating {

  // MARK: Properties

  private let duration: CFTimeInterval = 2
  private let timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let circleSize = size.width / 5
    let deltaX = size.width / 2 - circleSize / 2
    let deltaY = size.height / 2 - circleSize / 2
    let x = (layer.bounds.size.width - size.width) / 2
    let y = (layer.bounds.size.height - size.height) / 2
    let animation = self.animation

    let topCenterCircle = ActivityIndicatorShape.Ring.createLayerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
    changeAnimation(animation, values:["{0,0}", "{hx,fy}", "{-hx,fy}", "{0,0}"], deltaX: deltaX, deltaY: deltaY)
    topCenterCircle.frame = CGRect(x: x + size.width / 2 - circleSize / 2, y: y, width: circleSize, height: circleSize)
    topCenterCircle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(topCenterCircle)

    let bottomLeftCircle = ActivityIndicatorShape.Ring.createLayerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
    changeAnimation(animation, values: ["{0,0}", "{hx,-fy}", "{fx,0}", "{0,0}"], deltaX: deltaX, deltaY: deltaY)
    bottomLeftCircle.frame = CGRect(x: x, y: y + size.height - circleSize, width: circleSize, height: circleSize)
    bottomLeftCircle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(bottomLeftCircle)

    let bottomRightCircle = ActivityIndicatorShape.Ring.createLayerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
    changeAnimation(animation, values: ["{0,0}", "{-fx,0}", "{-hx,-fy}", "{0,0}"], deltaX: deltaX, deltaY:deltaY)
    bottomRightCircle.frame = CGRect(x: x + size.width - circleSize, y: y + size.height - circleSize, width: circleSize, height: circleSize)
    bottomRightCircle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(bottomRightCircle)
  }

}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallTrianglePath {

  var animation: CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath:"transform")
    animation.keyTimes = [0, 0.33, 0.66, 1]
    animation.timingFunctions = [timingFunction, timingFunction, timingFunction]
    animation.duration = duration
    animation.repeatCount = .infinity
    animation.removedOnCompletion = false
    return animation
  }

  func changeAnimation(animation: CAKeyframeAnimation, values rawValues: [String], deltaX: CGFloat, deltaY: CGFloat) -> CAAnimation {
    let values = NSMutableArray(capacity: 5)
    for rawValue in rawValues {
      let point = CGPointFromString(translateString(rawValue, deltaX: deltaX, deltaY: deltaY))
      values.addObject(NSValue(CATransform3D: CATransform3DMakeTranslation(point.x, point.y, 0)))
    }
    animation.values = values as [AnyObject]
    return animation
  }

  func translateString(valueString: String, deltaX: CGFloat, deltaY: CGFloat) -> String {
    let valueMutableString = NSMutableString(string: valueString)
    let fullDeltaX = 2 * deltaX
    let fullDeltaY = 2 * deltaY
    var range = NSRange(location: 0, length: valueMutableString.length)
    valueMutableString.replaceOccurrencesOfString("hx", withString: "\(deltaX)", options: NSStringCompareOptions.CaseInsensitiveSearch, range: range)
    range.length = valueMutableString.length
    valueMutableString.replaceOccurrencesOfString("fx", withString: "\(fullDeltaX)", options: NSStringCompareOptions.CaseInsensitiveSearch, range: range)
    range.length = valueMutableString.length
    valueMutableString.replaceOccurrencesOfString("hy", withString: "\(deltaY)", options: NSStringCompareOptions.CaseInsensitiveSearch, range: range)
    range.length = valueMutableString.length
    valueMutableString.replaceOccurrencesOfString("fy", withString: "\(fullDeltaY)", options: NSStringCompareOptions.CaseInsensitiveSearch, range: range)
    return valueMutableString as String
  }

}
