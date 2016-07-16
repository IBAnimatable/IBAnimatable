//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public typealias FrameTransformer = (finalFrame: CGRect, containerFrame: CGRect) -> CGRect

public protocol AnimatedPresenting: UIViewControllerAnimatedTransitioning {

  var transitionAnimationType: PresentationAnimationType { get set }
  var transitionDuration: Duration { get set }
  
}

public extension AnimatedPresenting {

  public func retrieveTransitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    if let transitionContext = transitionContext {
      return transitionContext.isAnimated() ? transitionDuration : 0
    }
    return 0
  }

  public func retrieveViews(transitionContext: UIViewControllerContextTransitioning) -> (UIView?, UIView?, UIView?) {
    return (transitionContext.viewForKey(UITransitionContextFromViewKey), transitionContext.viewForKey(UITransitionContextToViewKey), transitionContext.containerView())
  }

  public func retrieveViewControllers(transitionContext: UIViewControllerContextTransitioning) -> (UIViewController?, UIViewController?, UIView?) {
    return (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey), transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey), transitionContext.containerView())
  }

  public func isPresenting(transitionContext: UIViewControllerContextTransitioning) -> Bool {
    let (fromViewController, toViewController, _) = retrieveViewControllers(transitionContext)
    return toViewController?.presentingViewController == fromViewController
  }

}
