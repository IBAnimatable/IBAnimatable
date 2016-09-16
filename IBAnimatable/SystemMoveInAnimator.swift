//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class SystemMoveInAnimator: NSObject, AnimatedTransitioning {
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
      self.transitionAnimationType = .systemMoveIn(from: .right)
      self.reverseAnimationType = .systemMoveIn(from: .left)
      self.interactiveGestureType = .pan(from: .left)
    case .top:
      self.transitionAnimationType = .systemMoveIn(from: .top)
      self.reverseAnimationType = .systemMoveIn(from: .bottom)
      self.interactiveGestureType = .pan(from: .bottom)
    case .bottom:
      self.transitionAnimationType = .systemMoveIn(from: .bottom)
      self.reverseAnimationType = .systemMoveIn(from: .top)
      self.interactiveGestureType = .pan(from: .top)
    default:
      self.transitionAnimationType = .systemMoveIn(from: .left)
      self.reverseAnimationType = .systemMoveIn(from: .right)
      self.interactiveGestureType = .pan(from: .right)
    }
    
    super.init()
  }
}

extension SystemMoveInAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext: transitionContext, type: TransitionAnimationType.SystemTransitionType.moveIn, subtype: fromDirection.caTransitionSubtype)
  }
}
