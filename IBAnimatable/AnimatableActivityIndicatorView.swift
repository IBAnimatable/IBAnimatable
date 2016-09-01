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
  @IBInspectable public var animationType: String = "BallBeats"
  @IBInspectable public var color: UIColor = .blackColor()
  @IBInspectable public var hidesWhenStopped: Bool = true
  public var isAnimating: Bool = false

}
