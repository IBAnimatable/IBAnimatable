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
  private var animationOption: UIViewAnimationOptions
  
  public init(fromDirection: TransitionDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .Right:
      self.transitionAnimationType = .SystemFlip(fromDirection: .Right)
      self.reverseAnimationType = .SystemFlip(fromDirection: .Left)
      self.animationOption = .TransitionFlipFromRight
    case .Top:
      self.transitionAnimationType = .SystemFlip(fromDirection: .Top)
      self.reverseAnimationType = .SystemFlip(fromDirection: .Bottom)
      self.animationOption = .TransitionFlipFromTop
    case .Bottom:
      self.transitionAnimationType = .SystemFlip(fromDirection: .Bottom)
      self.reverseAnimationType = .SystemFlip(fromDirection: .Top)
      self.animationOption = .TransitionFlipFromBottom
    default:
      self.transitionAnimationType = .SystemFlip(fromDirection: .Left)
      self.reverseAnimationType = .SystemFlip(fromDirection: .Right)
      self.animationOption = .TransitionFlipFromLeft
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
