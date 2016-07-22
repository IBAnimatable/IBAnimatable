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
  private var fromDirection: TransitionDirection
  
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .Right:
      self.transitionAnimationType = .SystemMoveIn(fromDirection: .Right)
      self.reverseAnimationType = .SystemMoveIn(fromDirection: .Left)
      self.interactiveGestureType = .Pan(fromDirection: .Left)
    case .Top:
      self.transitionAnimationType = .SystemMoveIn(fromDirection: .Top)
      self.reverseAnimationType = .SystemMoveIn(fromDirection: .Bottom)
      self.interactiveGestureType = .Pan(fromDirection: .Bottom)
    case .Bottom:
      self.transitionAnimationType = .SystemMoveIn(fromDirection: .Bottom)
      self.reverseAnimationType = .SystemMoveIn(fromDirection: .Top)
      self.interactiveGestureType = .Pan(fromDirection: .Top)
    default:
      self.transitionAnimationType = .SystemMoveIn(fromDirection: .Left)
      self.reverseAnimationType = .SystemMoveIn(fromDirection: .Right)
      self.interactiveGestureType = .Pan(fromDirection: .Right)
    }
    
    super.init()
  }
}

extension SystemMoveInAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.MoveIn, subtype: fromDirection.CATransitionSubtype)
  }
}
