//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

/// Protocol for activity indicator animations.
public protocol ActivityIndicatorAnimatable: class {
  /// Animation type
  var animationType: String { get set }
  /// Color of the indicator
  var color: UIColor { get set }
  /// Specify whether hide the indicator when the animation stopped
  var hidesWhenStopped: Bool { get set }
  /// Animating status
  var isAnimating: Bool { get set }
}

public extension ActivityIndicatorAnimatable where Self: UIView {

  /// Start animating the activity indicator
  public func startAnimating() {
    isHidden = false
    configLayer()
    isAnimating = true
  }

  /// Stop animating the activity indicator
  public func stopAnimating() {
    layer.sublayers = nil
    isAnimating = false
    if hidesWhenStopped {
      isHidden = true
    }
  }

}

private extension ActivityIndicatorAnimatable where Self: UIView {

  func configLayer() {
    guard layer.sublayers == nil else {
      return
    }

    guard let activityIndicatorType = ActivityIndicatorType(string: animationType), activityIndicatorType != .none else {
      return
    }

    let activityIndicator = ActivityIndicatorFactory.generateActivityIndicator(activityIndicatorType: activityIndicatorType)
    activityIndicator.configAnimation(in: layer, size: bounds.size, color: color)
    layer.speed = 1
  }

}
