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
    configureNavigationControllerDelegate(transitionAnimationType, transitionDuration: transitionDuration)
  }

  // MARK: - Private
  // Must have a property to keep the reference alive because `UINavigationController.delegate` is `weak`
  private var navigator: Navigator?

  private func configureNavigationControllerDelegate(transitionAnimationType: String?, transitionDuration: Duration) {
    guard let transitionAnimationType = transitionAnimationType else {
      return
    }
    var duration = transitionDuration
    // Set the default duration for transition
    if transitionDuration.isNaN {
      duration = 0.5
    }
    navigator = Navigator(transitionAnimationType: transitionAnimationType, transitionDuration: duration)
    delegate = navigator
  }
}
