//
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Cube Animator - To support 3D animation (Four rotation directions supported: left, right, top, bottom)
 */
public class CubeAnimator: NSObject, UIViewControllerAnimatedTransitioning, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: String
  public var transitionDuration: Duration = .NaN
  public var reverseAnimationType: String?
  
  // MARK: - private
  private var fromDirection: TransitionFromDirection
  
  init(fromDirection: TransitionFromDirection, transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.fromDirection = fromDirection
    self.transitionAnimationType = String(fromDirection.animationType)
    self.reverseAnimationType = String(fromDirection.reverseAnimationType)
    super.init()
  }
  
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return transitionDuration
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: CATransitionType.cube, subtype: fromDirection.stringValue)
  }
}
