//
//  SystemPushAnimator.swift
//  IBAnimatableApp
//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SystemPushAnimator: NSObject, AnimatedTransitioning {
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
      self.transitionAnimationType = .SystemPush(direction: .Right)
      self.reverseAnimationType = .SystemPush(direction: .Left)
      self.interactiveGestureType = .Pan(direction: .Left)
    case .Top:
      self.transitionAnimationType = .SystemPush(direction: .Top)
      self.reverseAnimationType = .SystemPush(direction: .Bottom)
      self.interactiveGestureType = .Pan(direction: .Bottom)
    case .Bottom:
      self.transitionAnimationType = .SystemPush(direction: .Bottom)
      self.reverseAnimationType = .SystemPush(direction: .Top)
      self.interactiveGestureType = .Pan(direction: .Top)
    default:
      self.transitionAnimationType = .SystemPush(direction: .Left)
      self.reverseAnimationType = .SystemPush(direction: .Right)
      self.interactiveGestureType = .Pan(direction: .Right)
    }
    
    super.init()
  }
}

extension SystemPushAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Push, subtype: fromDirection.stringValue)
  }
}
