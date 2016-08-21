//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
public protocol ActivityIndicatorAnimatable: class {
  var animationType: String { get set }
  var color: UIColor { get set }
  var hidesWhenStopped: Bool { get set }
  var isAnimating: Bool { get set }
}

public extension ActivityIndicatorAnimatable where Self: UIView {

  public func startAnimating() {
    hidden = false
    configLayer()
    isAnimating = true
  }

  public func stopAnimating() {
    layer.sublayers = nil
    isAnimating = false
    hidden = hidesWhenStopped ? true : hidden
  }

}

private extension ActivityIndicatorAnimatable where Self: UIView {

  func configLayer() {
    guard layer.sublayers == nil else {
      return
    }

    layer.sublayers = nil
    let type = ActivityIndicatorType.fromString(animationType)
    guard type != .None else {
      return
    }

    let activityIndicator = ActivityIndicatorFactory.generateActivityIndicator(type)
    activityIndicator.configAnimation(in: layer, size: bounds.size, color: color)
    layer.speed = 1
  }

}