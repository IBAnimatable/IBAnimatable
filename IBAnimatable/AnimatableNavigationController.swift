//
//  Created by Jake Lin on 2/20/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class AnimatableNavigationController: UINavigationController, TransitionAnimatable {
  
  // MARK: - TransitionAnimatable
  @IBInspectable  var _transitionAnimationType: String? {
    didSet {
      if let _transitionAnimationType = _transitionAnimationType {
        transitionAnimationType = TransitionAnimationType.fromString(_transitionAnimationType)
      }
    }
  }
   open var transitionAnimationType: TransitionAnimationType? {
    didSet {
      configureNavigationControllerDelegate()
    }
  }
  @IBInspectable open var transitionDuration: Double = .nan {
    didSet {
      configureNavigationControllerDelegate()
    }
  }
  open var interactiveGestureType: InteractiveGestureType? {
    didSet {
      configureNavigationControllerDelegate()
    }
  }

  @IBInspectable var _interactiveGestureType: String? {
    didSet {
      if let _interactiveGestureType = _interactiveGestureType {
        interactiveGestureType = InteractiveGestureType.fromString(_interactiveGestureType)
      }
    }
  }
  
  // MARK: - Private
  // Must have a property to keep the reference alive because `UINavigationController.delegate` is `weak`
  fileprivate var navigator: Navigator?
  
  fileprivate func configureNavigationControllerDelegate() {
    guard let animationType = transitionAnimationType else {
      navigator = nil
      delegate = nil
      return
    }
    var duration = transitionDuration
    // Set the default duration for transition
    if transitionDuration.isNaN {
      duration = defaultTransitionDuration
    }
    if let gestureType = interactiveGestureType {
      navigator = Navigator(transitionAnimationType: animationType, transitionDuration: duration, interactiveGestureType: gestureType)
    } else {
      navigator = Navigator(transitionAnimationType: animationType, transitionDuration: duration)
    }
    delegate = navigator
  }
}
