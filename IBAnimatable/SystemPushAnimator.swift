//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class SystemPushAnimator: NSObject, AnimatedTransitioning {
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
      self.transitionAnimationType = .SystemPush(fromDirection: .Right)
      self.reverseAnimationType = .SystemPush(fromDirection: .Left)
      self.interactiveGestureType = .Pan(fromDirection: .Left)
    case .Top:
      self.transitionAnimationType = .SystemPush(fromDirection: .Top)
      self.reverseAnimationType = .SystemPush(fromDirection: .Bottom)
      self.interactiveGestureType = .Pan(fromDirection: .Bottom)
    case .Bottom:
      self.transitionAnimationType = .SystemPush(fromDirection: .Bottom)
      self.reverseAnimationType = .SystemPush(fromDirection: .Top)
      self.interactiveGestureType = .Pan(fromDirection: .Top)
    default:
      self.transitionAnimationType = .SystemPush(fromDirection: .Left)
      self.reverseAnimationType = .SystemPush(fromDirection: .Right)
      self.interactiveGestureType = .Pan(fromDirection: .Right)
    }
    
    super.init()
  }
}

extension SystemPushAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Push, subtype: fromDirection.CATransitionSubtype)
  }
}
