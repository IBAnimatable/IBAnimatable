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
    case .SystemSuckEffect:
      return SystemSuckEffectAnimator(transitionDuration: transitionDuration)
    case .SystemRippleEffect:
      return SystemRippleEffectAnimator(transitionDuration: transitionDuration)
    case .SystemCube(let direction):
      return SystemCubeAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case .SystemFlip(let direction):
      return SystemFlipAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case .SystemMoveIn(let direction):
      return SystemMoveInAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case .SystemPush(let direction):
      return SystemPushAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case .SystemReveal(let direction):
      return SystemRevealAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case .SystemPage(let type):
      return SystemPageAnimator(type: type, transitionDuration: transitionDuration)
    case .SystemCameraIris(let hollowState):
      return SystemCameraIrisAnimator(hollowState: hollowState, transitionDuration: transitionDuration)
    case .SystemRotate(let degree):
      return SystemRotateAnimator(withDegree: degree, transitionDuration: transitionDuration)
    }
  }
  
}
