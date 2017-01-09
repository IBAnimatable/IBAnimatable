//
//  AnimatableIndicatorView.swift
//  IBAnimatableApp
//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable
open class AnimatableActivityIndicatorView: UIView, ActivityIndicatorAnimatable {

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
  @IBInspectable open var color: UIColor = .black
  @IBInspectable open var hidesWhenStopped: Bool = true
  open var isAnimating: Bool = false
}
