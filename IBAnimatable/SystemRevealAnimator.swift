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
  private var fromDirection: TransitionDirection
  
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .systemReveal(fromDirection: .right)
      self.reverseAnimationType = .systemReveal(fromDirection: .left)
      self.interactiveGestureType = .pan(fromDirection: .Left)
    case .top:
      self.transitionAnimationType = .systemReveal(fromDirection: .top)
      self.reverseAnimationType = .systemReveal(fromDirection: .bottom)
      self.interactiveGestureType = .pan(fromDirection: .Bottom)
    case .bottom:
      self.transitionAnimationType = .systemReveal(fromDirection: .bottom)
      self.reverseAnimationType = .systemReveal(fromDirection: .top)
      self.interactiveGestureType = .pan(fromDirection: .Top)
    default:
      self.transitionAnimationType = .systemPush(fromDirection: .left)
      self.reverseAnimationType = .systemPush(fromDirection: .right)
      self.interactiveGestureType = .pan(fromDirection: .Right)
    }
    
    super.init()
  }
}

extension SystemRevealAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Reveal, subtype: fromDirection.CATransitionSubtype)
  }
}
