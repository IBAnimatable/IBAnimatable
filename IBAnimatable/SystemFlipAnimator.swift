//
//  Created by Jake Lin on 2/25/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 System Flip Animator - To support Flip animation (Four flip directions supported: left, right, top, bottom)
 */
public class SystemFlipAnimator: NSObject, AnimatedTransitioning {
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
      self.transitionAnimationType = .systemFlip(fromDirection: .right)
      self.reverseAnimationType = .systemFlip(fromDirection: .left)
      self.interactiveGestureType = .pan(fromDirection: .Left)
    case .top:
      self.transitionAnimationType = .systemFlip(fromDirection: .top)
      self.reverseAnimationType = .systemFlip(fromDirection: .bottom)
      self.interactiveGestureType = .pan(fromDirection: .Bottom)
    case .bottom:
      self.transitionAnimationType = .systemFlip(fromDirection: .bottom)
      self.reverseAnimationType = .systemFlip(fromDirection: .top)
      self.interactiveGestureType = .pan(fromDirection: .Top)
    default:
      self.transitionAnimationType = .systemFlip(fromDirection: .left)
      self.reverseAnimationType = .systemFlip(fromDirection: .right)
      self.interactiveGestureType = .pan(fromDirection: .Right)
    }
    
    super.init()
  }
}

extension SystemFlipAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(_ transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Flip, subtype: fromDirection.CATransitionSubtype)
  }
}
