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
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?

  // MARK: - private
  private var fromDirection: TransitionFromDirection
  
  init(fromDirection: TransitionFromDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .Left:
      self.transitionAnimationType = .SystemCubeFromLeft
      self.reverseAnimationType = .SystemCubeFromRight
      self.interactiveGestureType = .PanFromRight
    case .Right:
      self.transitionAnimationType = .SystemCubeFromRight
      self.reverseAnimationType = .SystemCubeFromLeft
      self.interactiveGestureType = .PanFromLeft
    case .Top:
      self.transitionAnimationType = .SystemCubeFromTop
      self.reverseAnimationType = .SystemCubeFromBottom
      self.interactiveGestureType = .PanFromTop
    case .Bottom:
      self.transitionAnimationType = .SystemCubeFromBottom
      self.reverseAnimationType = .SystemCubeFromTop
      self.interactiveGestureType = .PanFromBottom
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
