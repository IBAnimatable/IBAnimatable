//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class SystemRevealAnimator: NSObject, AnimatedTransitioning {
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
      self.transitionAnimationType = .SystemReveal(fromDirection: .Right)
      self.reverseAnimationType = .SystemReveal(fromDirection: .Left)
      self.interactiveGestureType = .Pan(fromDirection: .Left)
    case .Top:
      self.transitionAnimationType = .SystemReveal(fromDirection: .Top)
      self.reverseAnimationType = .SystemReveal(fromDirection: .Bottom)
      self.interactiveGestureType = .Pan(fromDirection: .Bottom)
    case .Bottom:
      self.transitionAnimationType = .SystemReveal(fromDirection: .Bottom)
      self.reverseAnimationType = .SystemReveal(fromDirection: .Top)
      self.interactiveGestureType = .Pan(fromDirection: .Top)
    default:
      self.transitionAnimationType = .SystemPush(fromDirection: .Left)
      self.reverseAnimationType = .SystemPush(fromDirection: .Right)
      self.interactiveGestureType = .Pan(fromDirection: .Right)
    }
    
    super.init()
  }
}

extension SystemRevealAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Reveal, subtype: fromDirection.CATransitionSubtype)
  }
}
