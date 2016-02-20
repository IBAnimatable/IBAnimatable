//
//  Created by Jake Lin on 2/20/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class FadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 0.25
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//    guard let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
//      toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
//      containerView = transitionContext.containerView() else {
//        transitionContext.completeTransition(true)
//        return
//    }
    
    
  }
}
