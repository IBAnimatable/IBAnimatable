//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
/**
 Animator Factory
 */
struct AnimatorFactory {
  static func generateAnimator(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration) -> AnimatedTransitioning {
    switch transitionAnimationType {
    case .CubeFromLeft:
      return CubeAnimator(fromDirection: .FromLeft, transitionDuration: transitionDuration)
    case .CubeFromRight:
      return CubeAnimator(fromDirection: .FromRight, transitionDuration: transitionDuration)
    case .CubeFromTop:
      return CubeAnimator(fromDirection: .FromTop, transitionDuration: transitionDuration)
    case .CubeFromBottom:
      return CubeAnimator(fromDirection: .FromBottom, transitionDuration: transitionDuration)
    }
  }
}
