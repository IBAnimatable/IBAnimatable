//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class SystemRotateAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  public init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.transitionAnimationType = .SystemRotate
    self.reverseAnimationType = .SystemRotate
    
    super.init()
  }
}

extension SystemRotateAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Rotate, subtype: "90")
  }
}
