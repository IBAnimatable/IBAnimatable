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
    case .Left:
      self.transitionAnimationType = .SystemPush(direction: .Left)
      self.reverseAnimationType = .SystemPush(direction: .Right)
      self.interactiveGestureType = .PanFromRight
    case .Right:
      self.transitionAnimationType = .SystemPush(direction: .Right)
      self.reverseAnimationType = .SystemPush(direction: .Left)
      self.interactiveGestureType = .PanFromLeft
    case .Top:
      self.transitionAnimationType = .SystemPush(direction: .Top)
      self.reverseAnimationType = .SystemPush(direction: .Bottom)
      self.interactiveGestureType = .PanFromBottom
    case .Bottom:
      self.transitionAnimationType = .SystemPush(direction: .Bottom)
      self.reverseAnimationType = .SystemPush(direction: .Top)
      self.interactiveGestureType = .PanFromTop
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
