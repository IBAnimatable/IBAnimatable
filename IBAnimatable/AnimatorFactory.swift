//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
/**
 Animator Factory
 */
public struct AnimatorFactory {
  public static func generateAnimator(transitionAnimationType: TransitionAnimationType) -> AnimatedTransitioning {
    return generateAnimator(transitionAnimationType, transitionDuration: defaultTransitionDuration)
  }

  public static func generateAnimator(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration) -> AnimatedTransitioning {
    switch transitionAnimationType {
    case .SystemRotate:
      return SystemRotateAnimator(transitionDuration: transitionDuration)
    case .SystemSuckEffect:
      return SystemSuckEffectAnimator(transitionDuration: transitionDuration)
    case .SystemRippleEffect:
      return SystemRippleEffectAnimator(transitionDuration: transitionDuration)
    case let .Explode(params):
      return ExplodeAnimator(params: params, transitionDuration: transitionDuration)
    case let .Fade(direction):
      return FadeAnimator(direction: direction, transitionDuration: transitionDuration)
    case let .Fold(direction, params):
      return FoldAnimator(fromDirection: direction, params: params, transitionDuration: transitionDuration)
    case let .Portal(direction, params):
      return PortalAnimator(fromDirection: direction, params: params, transitionDuration: transitionDuration)
    case let .NatGeo(direction):
      return NatGeoAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .Turn(direction):
      return TurnAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .Cards(direction):
      return CardsAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .Flip(direction):
      return FlipAnimator(fromDirection: direction, transitionDuration: transitionDuration)
    case let .Slide(direction, params):
      return SlideAnimator(fromDirection: direction, params: params, transitionDuration: transitionDuration)
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
    }
  }

  public static func generateAnimator(presentationAnimationType: PresentationAnimationType, transitionDuration: Duration) -> AnimatedPresenting {
    switch presentationAnimationType {
    case let .Cover(direction):
      return CoverAnimator(from: direction, transitionDuration: transitionDuration)
    case .Zoom:
      return ZoomAnimator(transitionDuration: transitionDuration)
    case .DropDown:
      return DropDownAnimator(transitionDuration: transitionDuration)
    case .Flip, .CrossDissolve: // System animation, will never be executed
      fatalError()
    }
  }

}
