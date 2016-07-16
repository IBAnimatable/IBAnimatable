//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class CoverAnimator: NSObject, AnimatedPresenting {

  // MARK: - AnimatedPresenting
  public var transitionAnimationType: PresentationAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration

  // MARK: - private
  private var direction: TransitionDirection

  public init(direction: TransitionDirection, transitionDuration: Duration) {
    self.direction = direction
    self.transitionDuration = transitionDuration

    switch direction {
    case .Left:
      self.transitionAnimationType = .Cover(fromDirection: .Left)
    case .Right:
      self.transitionAnimationType = .Cover(fromDirection: .Right)
    case .Top:
      self.transitionAnimationType = .Cover(fromDirection: .Top)
    default:
      self.transitionAnimationType = .Cover(fromDirection: .Bottom)
    }
    super.init()
  }
}

// MARK: - Animator

extension CoverAnimator: UIViewControllerAnimatedTransitioning {

  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }

  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animate(transitionContext) { finalFrame, containerFrame in
      var initialFrame = finalFrame
      switch self.direction {
      case .Right:
        initialFrame.origin.x = containerFrame.size.width + initialFrame.size.width
      case .Left:
        initialFrame.origin.x = 0 - initialFrame.size.width
      default: // .Top, .Bottom is handled by the system animation
        initialFrame.origin.y = 0 - initialFrame.size.height
      }
      return initialFrame
    }
  }

}
