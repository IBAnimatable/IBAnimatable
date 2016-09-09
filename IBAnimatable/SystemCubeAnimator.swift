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
  fileprivate var fromDirection: TransitionAnimationType.Direction
  
  public init(from direction: TransitionAnimationType.Direction, transitionDuration: Duration) {
    fromDirection = direction
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .systemCube(from: .right)
      self.reverseAnimationType = .systemCube(from: .left)
      self.interactiveGestureType = .pan(from: .left)
    case .top:
      self.transitionAnimationType = .systemCube(from: .top)
      self.reverseAnimationType = .systemCube(from: .bottom)
      self.interactiveGestureType = .pan(from: .bottom)
    case .bottom:
      self.transitionAnimationType = .systemCube(from: .bottom)
      self.reverseAnimationType = .systemCube(from: .top)
      self.interactiveGestureType = .pan(from: .top)
    default:
      self.transitionAnimationType = .systemCube(from: .left)
      self.reverseAnimationType = .systemCube(from: .right)
      self.interactiveGestureType = .pan(from: .right)
    }
    
    super.init()
  }
}

extension SystemCubeAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext: transitionContext, type: TransitionAnimationType.SystemTransitionType.cube, subtype: fromDirection.caTransitionSubtype)
  }
}
