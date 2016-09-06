//
//  Created by Tom Baranes on 28/03/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class SystemPageAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?
  
  // MARK: - private
  fileprivate var type: TransitionAnimationType.PageType
  
  public init(type: TransitionAnimationType.PageType, transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.type = type
    
    switch type {
    case .curl:
      self.transitionAnimationType = .systemPage(type: .curl)
      self.reverseAnimationType = .systemPage(type: .unCurl)
    case .unCurl:
      self.transitionAnimationType = .systemPage(type: .unCurl)
      self.reverseAnimationType = .systemPage(type: .curl)
    }
    
    super.init()
  }
}

extension SystemPageAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    switch self.type {
    case .curl:
      animateWithCATransition(transitionContext: transitionContext, type: TransitionAnimationType.SystemTransitionType.pageCurl, subtype: nil)
    case .unCurl:
      animateWithCATransition(transitionContext: transitionContext, type: TransitionAnimationType.SystemTransitionType.pageUnCurl, subtype: nil)
    }
  }
}
