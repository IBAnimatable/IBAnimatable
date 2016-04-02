//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SystemRotateAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var degree: TransitionRotateDegree
  
  init(withDegree degree: TransitionRotateDegree, transitionDuration: Duration) {
    self.degree = degree
    self.transitionDuration = transitionDuration
    
    switch degree {
    case .Ninety:
      self.transitionAnimationType = .SystemRotate(degree: .Ninety)
      self.reverseAnimationType = .SystemRotate(degree: .NinetyCCW)
    case .NinetyCCW:
      self.transitionAnimationType = .SystemRotate(degree: .NinetyCCW)
      self.reverseAnimationType = .SystemRotate(degree: .Ninety)
    case .OneHundredHeighty:
      self.transitionAnimationType = .SystemRotate(degree: .OneHundredHeighty)
      self.reverseAnimationType = .SystemRotate(degree: .OneHundredHeightyCCW)
    case .OneHundredHeightyCCW:
      self.transitionAnimationType = .SystemRotate(degree: .OneHundredHeightyCCW)
      self.reverseAnimationType = .SystemRotate(degree: .OneHundredHeighty)
    }
    
    super.init()
  }
}

extension SystemRotateAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext, type: SystemTransitionType.Rotate, subtype: degree.stringValue)
  }
}
