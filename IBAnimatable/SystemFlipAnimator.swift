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
  private var fromDirection: TransitionFromDirection
  private var animationOption: UIViewAnimationOptions
  
  init(fromDirection: TransitionFromDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .Left:
      self.transitionAnimationType = .SystemFlip(direction: .Left)
      self.reverseAnimationType = .SystemFlip(direction: .Right)
      self.animationOption = .TransitionFlipFromLeft
    case .Right:
      self.transitionAnimationType = .SystemFlip(direction: .Right)
      self.reverseAnimationType = .SystemFlip(direction: .Left)
      self.animationOption = .TransitionFlipFromRight
    case .Top:
      self.transitionAnimationType = .SystemFlip(direction: .Top)
      self.reverseAnimationType = .SystemFlip(direction: .Bottom)
      self.animationOption = .TransitionFlipFromTop
    case .Bottom:
      self.transitionAnimationType = .SystemFlip(direction: .Bottom)
      self.reverseAnimationType = .SystemFlip(direction: .Top)
      self.animationOption = .TransitionFlipFromBottom
    }
    
    super.init()
  }
}

extension SystemFlipAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Flip, subtype: fromDirection.stringValue)
  }
}
