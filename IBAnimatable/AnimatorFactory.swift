//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
/**
 Animator Factory
 */
public struct AnimatorFactory {
  public static func generateAnimator(_ transitionAnimationType: TransitionAnimationType) -> AnimatedTransitioning {
    return generateAnimator(transitionAnimationType, transitionDuration: defaultTransitionDuration)
  }

  public static func generateAnimator(_ transitionAnimationType: TransitionAnimationType, transitionDuration: Duration) -> AnimatedTransitioning {
    switch transitionAnimationType {
    case .systemRotate:
      return SystemRotateAnimator(transitionDuration: transitionDuration)
    case .systemSuckEffect:
      return SystemSuckEffectAnimator(transitionDuration: transitionDuration)
    case .systemRippleEffect:
      return SystemRippleEffectAnimator(transitionDuration: transitionDuration)
    case let .explode(params):
      return ExplodeAnimator(params: params, transitionDuration: transitionDuration)
    case let .fade(direction):
      return FadeAnimator(direction: direction, transitionDuration: transitionDuration)
    case let .fold(direction, params):
      return FoldAnimator(fromDirection: direction, params: params, transitionDuration: transitionDuration)
    case let .portal(direction, params):
      return PortalAnimator(fromDirection: direction, params: params, transitionDuration: transitionDuration)
    case let .natGeo(direction):
      return NatGeoAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .turn(direction):
      return TurnAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .cards(direction):
      return CardsAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .flip(direction):
      return FlipAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .slide(direction, params):
      return SlideAnimator(fromDirection: direction, params: params, transitionDuration: transitionDuration)
    case let .systemCube(direction):
      return SystemCubeAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .systemFlip(direction):
      return SystemFlipAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .systemMoveIn(direction):
      return SystemMoveInAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .systemPush(direction):
      return SystemPushAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .systemReveal(direction):
      return SystemRevealAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .systemPage(type):
      return SystemPageAnimator(type: type, transitionDuration: transitionDuration)
    case let .systemCameraIris(hollowState):
      return SystemCameraIrisAnimator(hollowState: hollowState, transitionDuration: transitionDuration)
    }
  }
  
}
