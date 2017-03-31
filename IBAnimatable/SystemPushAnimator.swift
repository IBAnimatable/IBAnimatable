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
  fileprivate var fromDirection: TransitionAnimationType.Direction

  public init(from direction: TransitionAnimationType.Direction, transitionDuration: Duration) {
    fromDirection = direction
    self.transitionDuration = transitionDuration

    switch direction {
    case .right, .top, .bottom:
      self.transitionAnimationType = .systemPush(from: direction)
      self.reverseAnimationType = .systemPush(from: direction.opposite)
      self.interactiveGestureType = .pan(from: direction.opposingGesture)
    default:
      self.transitionAnimationType = .systemPush(from: .left)
      self.reverseAnimationType = .systemPush(from: .right)
      self.interactiveGestureType = .pan(from: .right)
    }

    super.init()
  }
}

extension SystemPushAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext: transitionContext,
                            type: TransitionAnimationType.SystemTransitionType.push,
                            subtype: fromDirection.caTransitionSubtype)
  }
}
