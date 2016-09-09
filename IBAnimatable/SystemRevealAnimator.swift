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
  fileprivate var fromDirection: TransitionAnimationType.Direction
  
  public init(from direction: TransitionAnimationType.Direction, transitionDuration: Duration) {
    fromDirection = direction
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .systemReveal(from: .right)
      self.reverseAnimationType = .systemReveal(from: .left)
      self.interactiveGestureType = .pan(from: .left)
    case .top:
      self.transitionAnimationType = .systemReveal(from: .top)
      self.reverseAnimationType = .systemReveal(from: .bottom)
      self.interactiveGestureType = .pan(from: .bottom)
    case .bottom:
      self.transitionAnimationType = .systemReveal(from: .bottom)
      self.reverseAnimationType = .systemReveal(from: .top)
      self.interactiveGestureType = .pan(from: .top)
    default:
      self.transitionAnimationType = .systemPush(from: .left)
      self.reverseAnimationType = .systemPush(from: .right)
      self.interactiveGestureType = .pan(from: .right)
    }
    
    super.init()
  }
}

extension SystemRevealAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext: transitionContext, type: TransitionAnimationType.SystemTransitionType.reveal, subtype: fromDirection.caTransitionSubtype)
  }
}
