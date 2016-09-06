//
//  Created by Tom Baranes on 30/03/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class SystemCameraIrisAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  fileprivate var hollowState: TransitionAnimationType.HollowState
  
  public init(hollowState: TransitionAnimationType.HollowState, transitionDuration: Duration) {    
    self.transitionDuration = transitionDuration
    self.hollowState = hollowState
    
    switch hollowState {
    case .open:
      self.transitionAnimationType = .systemCameraIris(hollowState: .open)
      self.reverseAnimationType = .systemCameraIris(hollowState: .close)
      self.interactiveGestureType = .pinch(direction: .close)
    case .close:
      self.transitionAnimationType = .systemCameraIris(hollowState: .close)
      self.reverseAnimationType = .systemCameraIris(hollowState: .open)
      self.interactiveGestureType = .pinch(direction: .open)
    case .none:
      self.transitionAnimationType = .systemCameraIris(hollowState: .none)
      self.reverseAnimationType = .systemCameraIris(hollowState: .none)
      self.interactiveGestureType = .pinch(direction: .close)
    }
    
    super.init()
  }
}

extension SystemCameraIrisAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    switch self.hollowState {
    case .open:
      animateWithCATransition(transitionContext: transitionContext, type: TransitionAnimationType.SystemTransitionType.cameraIrisHollowOpen, subtype: nil)
    case .close:
      animateWithCATransition(transitionContext: transitionContext, type: TransitionAnimationType.SystemTransitionType.cameraIrisHollowClose, subtype: nil)
    case .none:
      animateWithCATransition(transitionContext: transitionContext, type: TransitionAnimationType.SystemTransitionType.cameraIris, subtype: nil)

    }
  }
}
