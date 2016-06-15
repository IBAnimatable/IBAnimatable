//
//  Created by Tom Baranes on 30/03/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SystemSuckEffectAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  public init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.transitionAnimationType = .systemSuckEffect
    self.reverseAnimationType = .systemSuckEffect
    super.init()
  }
}

extension SystemSuckEffectAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.SuckEffect, subtype: nil)
  }
}
