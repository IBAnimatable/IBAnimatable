//
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 System Cube Animator - To support 3D animation (Four rotation directions supported: left, right, top, bottom)
 */
public class SystemCubeAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = 0.35
  public var reverseAnimationType: TransitionAnimationType?
  
  // MARK: - private
  private var fromDirection: TransitionFromDirection
  
  init(fromDirection: TransitionFromDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .FromLeft:
      self.transitionAnimationType = TransitionAnimationType.CubeFromLeft
      self.reverseAnimationType = TransitionAnimationType.CubeFromRight
    case .FromRight:
      self.transitionAnimationType = TransitionAnimationType.CubeFromRight
      self.reverseAnimationType = TransitionAnimationType.CubeFromLeft
    case .FromTop:
      self.transitionAnimationType = TransitionAnimationType.CubeFromTop
      self.reverseAnimationType = TransitionAnimationType.CubeFromBottom
    case .FromBottom:
      self.transitionAnimationType = TransitionAnimationType.CubeFromBottom
      self.reverseAnimationType = TransitionAnimationType.CubeFromTop
    }
    
    super.init()
  }
}

extension SystemCubeAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Cube, subtype: fromDirection.stringValue)
  }
}
