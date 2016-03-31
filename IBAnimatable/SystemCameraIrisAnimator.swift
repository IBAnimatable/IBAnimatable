//
//  SystemCameraIrisAnmator.swift
//  IBAnimatableApp
//
//  Created by Tom Baranes on 30/03/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SystemCameraIrisAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var hollowState: TransitionHollowState
  
  init(hollowState: TransitionHollowState, transitionDuration: Duration) {    
    self.transitionDuration = transitionDuration
    self.hollowState = hollowState
    
    switch hollowState {
    case .Open:
      self.transitionAnimationType = .SystemCameraIris(hollowState: .Open)
      self.reverseAnimationType = .SystemCameraIris(hollowState: .Close)
    case .Close:
      self.transitionAnimationType = .SystemCameraIris(hollowState: .Close)
      self.reverseAnimationType = .SystemCameraIris(hollowState: .Open)
    case .None:
      self.transitionAnimationType = .SystemCameraIris(hollowState: .None)
      self.reverseAnimationType = .SystemCameraIris(hollowState: .None)
    }
    
    super.init()
  }
}

extension SystemCameraIrisAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    switch self.hollowState {
    case .Open:
      animateWithCATransition(transitionContext, type: SystemTransitionType.CameraIrisHollowOpen, subtype: nil)
    case .Close:
      animateWithCATransition(transitionContext, type: SystemTransitionType.CameraIrisHollowClose, subtype: nil)
    case .None:
      animateWithCATransition(transitionContext, type: SystemTransitionType.CameraIris, subtype: nil)

    }
  }
}
