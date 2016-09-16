//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public protocol AnimatedPresenting: ViewControllerAnimatedTransitioning {

}

public extension AnimatedPresenting {
  public func isPresenting(transitionContext: UIViewControllerContextTransitioning) -> Bool {
    let (fromViewController, toViewController, _) = retrieveViewControllers(transitionContext: transitionContext)
    return toViewController?.presentingViewController == fromViewController
  }
}
