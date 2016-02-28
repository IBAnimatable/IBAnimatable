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
      self.transitionAnimationType = .SystemCubeFromLeft
      self.reverseAnimationType = .SystemCubeFromRight
    case .FromRight:
      self.transitionAnimationType = .SystemCubeFromRight
      self.reverseAnimationType = .SystemCubeFromLeft
    case .FromTop:
      self.transitionAnimationType = .SystemCubeFromTop
      self.reverseAnimationType = .SystemCubeFromBottom
    case .FromBottom:
      self.transitionAnimationType = .SystemCubeFromBottom
      self.reverseAnimationType = .SystemCubeFromTop
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
