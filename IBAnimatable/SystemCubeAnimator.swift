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
  private var fromDirection: TransitionDirection
  
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .systemCube(fromDirection: .right)
      self.reverseAnimationType = .systemCube(fromDirection: .left)
      self.interactiveGestureType = .pan(fromDirection: .Left)
    case .top:
      self.transitionAnimationType = .systemCube(fromDirection: .top)
      self.reverseAnimationType = .systemCube(fromDirection: .bottom)
      self.interactiveGestureType = .pan(fromDirection: .Bottom)
    case .bottom:
      self.transitionAnimationType = .systemCube(fromDirection: .bottom)
      self.reverseAnimationType = .systemCube(fromDirection: .top)
      self.interactiveGestureType = .pan(fromDirection: .Top)
    default:
      self.transitionAnimationType = .systemCube(fromDirection: .left)
      self.reverseAnimationType = .systemCube(fromDirection: .right)
      self.interactiveGestureType = .pan(fromDirection: .Right)
    }
    
    super.init()
  }
}

extension SystemCubeAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Cube, subtype: fromDirection.CATransitionSubtype)
  }
}
