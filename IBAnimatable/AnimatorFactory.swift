//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
/**
 Animator Factory
 */
struct AnimatorFactory {
  static func generateAnimator(transitionAnimationType: TransitionAnimationType) -> AnimatedTransitioning {
    return generateAnimator(transitionAnimationType, transitionDuration: defaultTransitionDuration)
  }

  static func generateAnimator(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration) -> AnimatedTransitioning {
    switch transitionAnimationType {
    case .Fade:
      return FadeAnimator(fadeType: .Fade, transitionDuration: transitionDuration)
    case .FadeIn:
      return FadeAnimator(fadeType: .FadeIn, transitionDuration: transitionDuration)
    case .FadeOut:
      return FadeAnimator(fadeType: .FadeOut, transitionDuration: transitionDuration)
    case .SystemCube(let direction):
      return SystemCubeAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case .SystemFlip(let direction):
      return SystemFlipAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case .SystemPageCurl(let direction):
      return SystemPageCurlAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    }
  }
  
}
