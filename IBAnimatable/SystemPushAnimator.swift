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
  
  public init(fromDirection: TransitionAnimationType.Direction, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .systemPush(fromDirection: .right)
      self.reverseAnimationType = .systemPush(fromDirection: .left)
      self.interactiveGestureType = .pan(fromDirection: .left)
    case .top:
      self.transitionAnimationType = .systemPush(fromDirection: .top)
      self.reverseAnimationType = .systemPush(fromDirection: .bottom)
      self.interactiveGestureType = .pan(fromDirection: .bottom)
    case .bottom:
      self.transitionAnimationType = .systemPush(fromDirection: .bottom)
      self.reverseAnimationType = .systemPush(fromDirection: .top)
      self.interactiveGestureType = .pan(fromDirection: .top)
    default:
      self.transitionAnimationType = .systemPush(fromDirection: .left)
      self.reverseAnimationType = .systemPush(fromDirection: .right)
      self.interactiveGestureType = .pan(fromDirection: .right)
    }
    
    super.init()
  }
}

extension SystemPushAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext: transitionContext, type: SystemTransitionType.push, subtype: fromDirection.CATransitionSubtype)
  }
}
