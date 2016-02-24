//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation
/**
 Animator Factory
 */
struct AnimatorFactory {
  static func generateAnimator(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration) -> AnimatedTransitioning {
    switch transitionAnimationType {
    case .CubeFromLeft:
      return CubeFromLeftAnimator(transitionDuration: transitionDuration)
    case .CubeFromRight:
      return CubeFromRightAnimator(transitionDuration: transitionDuration)
    case .CubeFromTop:
      return CubeFromLeftAnimator(transitionDuration: transitionDuration)
    case .CubeFromBottom:
      return CubeFromLeftAnimator(transitionDuration: transitionDuration)
    }
  }
}
