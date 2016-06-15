//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SystemMoveInAnimator: NSObject, AnimatedTransitioning {
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
      self.transitionAnimationType = .systemMoveIn(fromDirection: .right)
      self.reverseAnimationType = .systemMoveIn(fromDirection: .left)
      self.interactiveGestureType = .pan(fromDirection: .Left)
    case .top:
      self.transitionAnimationType = .systemMoveIn(fromDirection: .top)
      self.reverseAnimationType = .systemMoveIn(fromDirection: .bottom)
      self.interactiveGestureType = .pan(fromDirection: .Bottom)
    case .bottom:
      self.transitionAnimationType = .systemMoveIn(fromDirection: .bottom)
      self.reverseAnimationType = .systemMoveIn(fromDirection: .top)
      self.interactiveGestureType = .pan(fromDirection: .Top)
    default:
      self.transitionAnimationType = .systemMoveIn(fromDirection: .left)
      self.reverseAnimationType = .systemMoveIn(fromDirection: .right)
      self.interactiveGestureType = .pan(fromDirection: .Right)
    }
    
    super.init()
  }
}

extension SystemMoveInAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.MoveIn, subtype: fromDirection.CATransitionSubtype)
  }
}
