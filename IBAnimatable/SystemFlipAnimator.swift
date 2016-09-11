//
//  Created by Jake Lin on 2/25/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
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
  fileprivate var fromDirection: TransitionAnimationType.Direction
  
  public init(from direction: TransitionAnimationType.Direction, transitionDuration: Duration) {
    fromDirection = direction
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .systemFlip(from: .right)
      self.reverseAnimationType = .systemFlip(from: .left)
      self.interactiveGestureType = .pan(from: .left)
    case .top:
      self.transitionAnimationType = .systemFlip(from: .top)
      self.reverseAnimationType = .systemFlip(from: .bottom)
      self.interactiveGestureType = .pan(from: .bottom)
    case .bottom:
      self.transitionAnimationType = .systemFlip(from: .bottom)
      self.reverseAnimationType = .systemFlip(from: .top)
      self.interactiveGestureType = .pan(from: .top)
    default:
      self.transitionAnimationType = .systemFlip(from: .left)
      self.reverseAnimationType = .systemFlip(from: .right)
      self.interactiveGestureType = .pan(from: .right)
    }
    
    super.init()
  }
}

extension SystemFlipAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext: transitionContext, type: TransitionAnimationType.SystemTransitionType.flip, subtype: fromDirection.caTransitionSubtype)
  }
}
