//
//  Created by Jake Lin on 2/20/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class FadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  let transitionDuration = 3.0
  
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return transitionDuration
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    guard let _ = transitionContext.viewForKey(UITransitionContextFromViewKey),
      toView = transitionContext.viewForKey(UITransitionContextToViewKey),
      containerView = transitionContext.containerView() else {
        transitionContext.completeTransition(true)
        return
    }
    
    containerView.addSubview(toView)
    CALayer.animate({
      let transition = CATransition()
      transition.type = "flip" // kCATransitionReveal
      transition.subtype = kCATransitionFromTop
      transition.duration = self.transitionDuration(transitionContext)
      
      containerView.layer.addAnimation(transition, forKey: kCATransition)
      }) {
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
}
