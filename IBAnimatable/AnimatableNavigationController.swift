//
//  Created by Jake Lin on 2/20/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class AnimatableNavigationController: UINavigationController, TransitionAnimatable {
  
  // MARK: - TransitionAnimatable
  @IBInspectable public var transitionAnimationType: String? {
    didSet {
      configureNavigationControllerDelegate()
    }
  }
  @IBInspectable public var transitionDuration: Double = .NaN {
    didSet {
      configureNavigationControllerDelegate()
    }
  }
  @IBInspectable public var interactiveGestureType: String? {
    didSet {
      configureNavigationControllerDelegate()
    }
  }
  
  // MARK: - Lifecylce
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationControllerDelegate()
  }
  
  // MARK: - Private
  // Must have a property to keep the reference alive because `UINavigationController.delegate` is `weak`
  private var navigator: Navigator?
  
  private func configureNavigationControllerDelegate() {
    guard let transitionAnimationType = transitionAnimationType, animationType = TransitionAnimationType.fromString(transitionAnimationType) else {
      navigator = nil
      delegate = nil
      return
    }
    var duration = transitionDuration
    // Set the default duration for transition
    if transitionDuration.isNaN {
      duration = defaultTransitionDuration
    }
    if let interactiveGestureType = interactiveGestureType, gestureType = InteractiveGestureType.fromString(interactiveGestureType) {
      navigator = Navigator(transitionAnimationType: animationType, transitionDuration: duration, interactiveGestureType: gestureType)
    } else {
      navigator = Navigator(transitionAnimationType: animationType, transitionDuration: duration)
    }
    delegate = navigator
  }
}
