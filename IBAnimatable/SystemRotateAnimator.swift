//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

open class SystemRotateAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  open var transitionAnimationType: TransitionAnimationType
  open var transitionDuration: Duration = defaultTransitionDuration
  open var reverseAnimationType: TransitionAnimationType?
  open var interactiveGestureType: InteractiveGestureType?
  
  public init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.transitionAnimationType = .systemRotate
    self.reverseAnimationType = .systemRotate
    
    super.init()
  }
}

extension SystemRotateAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return getTransitionDuration(using: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(using: transitionContext, type: SystemTransitionType.rotate, subtype: "90")
  }
}
