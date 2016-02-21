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
    guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
      toView = transitionContext.viewForKey(UITransitionContextToViewKey),
      _ = transitionContext.containerView() else {
        transitionContext.completeTransition(true)
        return
    }

    UIView.transitionFromView(fromView, toView: toView, duration: transitionDuration(transitionContext), options: .TransitionFlipFromLeft) { (completed) -> Void in
      transitionContext.completeTransition(completed)
    }
  }
}
