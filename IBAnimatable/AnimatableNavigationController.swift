//
//  Created by Jake Lin on 2/20/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class AnimatableNavigationController: UINavigationController, TransitionAnimatable {
  
  // MARK: - TransitionAnimatable
  @IBInspectable public var transitionAnimationType: String?
  @IBInspectable public var transitionDuration: Double = .NaN

  // MARK: - Lifecylce
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationControllerDelegate()
  }

  // MARK: - Private
  // Must have a property to keep the reference alive because `UINavigationController.delegate` is `weak`
  private var navigator: Navigator?

  private func configureNavigationControllerDelegate() {
    guard let transitionAnimationType = transitionAnimationType, animationType = TransitionAnimationType(rawValue: transitionAnimationType) else {
      return
    }
    var duration = transitionDuration
    // Set the default duration for transition
    if transitionDuration.isNaN {
      duration = 0.35
    }
    navigator = Navigator(transitionAnimationType: animationType, transitionDuration: duration)
    delegate = navigator
  }
}
