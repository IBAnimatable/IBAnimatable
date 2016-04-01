//
//  Created by Tom Baranes on 28/03/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class SystemPageAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  private var type: TransitionPageType
  
  init(type: TransitionPageType, transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.type = type
    
    switch type {
    case .Curl:
      self.transitionAnimationType = .SystemPage(type: .Curl)
      self.reverseAnimationType = .SystemPage(type: .UnCurl)
    case .UnCurl:
      self.transitionAnimationType = .SystemPage(type: .UnCurl)
      self.reverseAnimationType = .SystemPage(type: .Curl)
    }
    
    super.init()
  }
}

extension SystemPageAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return retrieveTransitionDuration(transitionContext)
  }
  
  public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    switch self.type {
    case .Curl:
      animateWithCATransition(transitionContext, type: SystemTransitionType.PageCurl, subtype: nil)
    case .UnCurl:
      animateWithCATransition(transitionContext, type: SystemTransitionType.PageUnCurl, subtype: nil)
    }
  }
}
