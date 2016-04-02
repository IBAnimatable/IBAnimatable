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
  private var fromDirection: TransitionFromDirection
  
  init(fromDirection: TransitionFromDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .Left:
      self.transitionAnimationType = .SystemMoveIn(direction: .Left)
      self.reverseAnimationType = .SystemMoveIn(direction: .Right)
      self.interactiveGestureType = .PanFromRight
    case .Right:
      self.transitionAnimationType = .SystemMoveIn(direction: .Right)
      self.reverseAnimationType = .SystemMoveIn(direction: .Left)
      self.interactiveGestureType = .PanFromLeft
    case .Top:
      self.transitionAnimationType = .SystemMoveIn(direction: .Top)
      self.reverseAnimationType = .SystemMoveIn(direction: .Bottom)
      self.interactiveGestureType = .PanFromBottom
    case .Bottom:
      self.transitionAnimationType = .SystemMoveIn(direction: .Bottom)
      self.reverseAnimationType = .SystemMoveIn(direction: .Top)
      self.interactiveGestureType = .PanFromTop
    }
    
    super.init()
  }
}

extension SystemMoveInAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.MoveIn, subtype: fromDirection.stringValue)
  }
}
