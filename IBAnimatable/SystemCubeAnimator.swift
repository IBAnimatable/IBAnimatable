//
//  Copyright © 2016 IBAnimatable. All rights reserved.
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
  private var fromDirection: TransitionDirection
  
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .Right:
      self.transitionAnimationType = .SystemCube(fromDirection: .Right)
      self.reverseAnimationType = .SystemCube(fromDirection: .Left)
      self.interactiveGestureType = .Pan(fromDirection: .Left)
    case .Top:
      self.transitionAnimationType = .SystemCube(fromDirection: .Top)
      self.reverseAnimationType = .SystemCube(fromDirection: .Bottom)
      self.interactiveGestureType = .Pan(fromDirection: .Bottom)
    case .Bottom:
      self.transitionAnimationType = .SystemCube(fromDirection: .Bottom)
      self.reverseAnimationType = .SystemCube(fromDirection: .Top)
      self.interactiveGestureType = .Pan(fromDirection: .Top)
    default:
      self.transitionAnimationType = .SystemCube(fromDirection: .Left)
      self.reverseAnimationType = .SystemCube(fromDirection: .Right)
      self.interactiveGestureType = .Pan(fromDirection: .Right)
    }
    
    super.init()
  }
}

extension SystemCubeAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Cube, subtype: fromDirection.CATransitionSubtype)
  }
}
