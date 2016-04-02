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
      self.transitionAnimationType = .SystemCube(direction: .Left)
      self.reverseAnimationType = .SystemCube(direction: .Right)
      self.interactiveGestureType = .PanFromRight
    case .Right:
      self.transitionAnimationType = .SystemCube(direction: .Right)
      self.reverseAnimationType = .SystemCube(direction: .Left)
      self.interactiveGestureType = .PanFromLeft
    case .Top:
      self.transitionAnimationType = .SystemCube(direction: .Top)
      self.reverseAnimationType = .SystemCube(direction: .Bottom)
      self.interactiveGestureType = .PanFromBottom
    case .Bottom:
      self.transitionAnimationType = .SystemCube(direction: .Bottom)
      self.reverseAnimationType = .SystemCube(direction: .Top)
      self.interactiveGestureType = .PanFromTop
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
