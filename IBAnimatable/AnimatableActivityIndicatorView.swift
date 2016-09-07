//
//  AnimatableIndicatorView.swift
//  IBAnimatableApp
//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableActivityIndicatorView: UIView, ActivityIndicatorAnimatable {

  // MARK: ActivityIndicatorAnimatable
  open var animationType: ActivityIndicatorType = .none
  @IBInspectable var _animationType: String? {
    didSet {
      if let type = _animationType, let animationType = ActivityIndicatorType(string: type) {
        self.animationType = animationType
      } else {
        animationType = .none
      }
    }
  }
  @IBInspectable public var color: UIColor = .black
  @IBInspectable public var hidesWhenStopped: Bool = true
  public var isAnimating: Bool = false
}
