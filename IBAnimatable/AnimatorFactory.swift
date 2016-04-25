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
    case let .Explode(params):
      return ExplodeAnimator(params: params, transitionDuration: transitionDuration)
    case let .Fold(direction, params):
      return FoldAnimator(fromDirection: direction, params: params, transitionDuration: transitionDuration)
    case let .Portal(direction, params):
      return PortalAnimator(fromDirection: direction, params: params, transitionDuration: transitionDuration)
    case let .NatGeo(direction):
      return NatGeoAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .SystemCube(direction):
      return SystemCubeAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .SystemFlip(direction):
      return SystemFlipAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .SystemMoveIn(direction):
      return SystemMoveInAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .SystemPush(direction):
      return SystemPushAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .SystemReveal(direction):
      return SystemRevealAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .SystemPage(type):
      return SystemPageAnimator(type: type, transitionDuration: transitionDuration)
    case let .SystemCameraIris(hollowState):
      return SystemCameraIrisAnimator(hollowState: hollowState, transitionDuration: transitionDuration)
    case let .SystemRotate(degree):
      return SystemRotateAnimator(withDegree: degree, transitionDuration: transitionDuration)
    }
  }
  
}
