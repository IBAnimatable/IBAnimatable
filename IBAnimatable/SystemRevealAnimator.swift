//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SystemRevealAnimator: NSObject, AnimatedTransitioning {
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
    case .Right:
      self.transitionAnimationType = .SystemReveal(direction: .Right)
      self.reverseAnimationType = .SystemReveal(direction: .Left)
      self.interactiveGestureType = .Pan(direction: .Left)
    case .Top:
      self.transitionAnimationType = .SystemReveal(direction: .Top)
      self.reverseAnimationType = .SystemReveal(direction: .Bottom)
      self.interactiveGestureType = .Pan(direction: .Bottom)
    case .Bottom:
      self.transitionAnimationType = .SystemReveal(direction: .Bottom)
      self.reverseAnimationType = .SystemReveal(direction: .Top)
      self.interactiveGestureType = .Pan(direction: .Top)
    default:
      self.transitionAnimationType = .SystemPush(direction: .Left)
      self.reverseAnimationType = .SystemPush(direction: .Right)
      self.interactiveGestureType = .Pan(direction: .Right)
    }
    
    super.init()
  }
}

extension SystemRevealAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Reveal, subtype: fromDirection.stringValue)
  }
}
