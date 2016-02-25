//
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Cube Animator - To support 3D animation (Four rotation directions supported: left, right, top, bottom)
 */
public class CubeAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: String
  public var transitionDuration: Duration = .NaN
  public var reverseAnimationType: String?
  
  // MARK: - private
  private var fromDirection: TransitionFromDirection
  
  init(fromDirection: TransitionFromDirection, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .FromLeft:
      self.transitionAnimationType = String(TransitionAnimationType.CubeFromLeft)
      self.reverseAnimationType = String(TransitionAnimationType.CubeFromRight)
    case .FromRight:
      self.transitionAnimationType = String(TransitionAnimationType.CubeFromRight)
      self.reverseAnimationType = String(TransitionAnimationType.CubeFromRight)
    case .FromTop:
      self.transitionAnimationType = String(TransitionAnimationType.CubeFromTop)
      self.reverseAnimationType = String(TransitionAnimationType.CubeFromRight)
    case .FromBottom:
      self.transitionAnimationType = String(TransitionAnimationType.CubeFromBottom)
      self.reverseAnimationType = String(TransitionAnimationType.CubeFromRight)
    }
    
    super.init()
  }
}

extension CubeAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return transitionDuration
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: CATransitionType.cube, subtype: fromDirection.stringValue)
  }
}
