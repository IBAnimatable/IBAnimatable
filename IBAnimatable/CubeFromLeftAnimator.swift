//
//  Created by Jake Lin on 2/20/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class CubeFromLeftAnimator: NSObject, UIViewControllerAnimatedTransitioning, AnimatorProtocol {
  // MARK: - AnimatorProtocol
  var transitionAnimationType = String(TransitionAnimationType.CubeFromLeft)
  var transitionDuration = Duration.NaN

  init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    super.init()
  }
  
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
      transition.type = "cube"
      transition.subtype = kCATransitionFromLeft
      transition.duration = self.transitionDuration(transitionContext)
      
      containerView.layer.addAnimation(transition, forKey: kCATransition)
      }) {
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
    }
  }
}
