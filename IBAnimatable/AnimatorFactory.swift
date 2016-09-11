//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
/**
 Animator Factory
 */
public struct AnimatorFactory {
  public static func makeAnimator(transitionAnimationType: TransitionAnimationType, transitionDuration: Duration = defaultTransitionDuration) -> AnimatedTransitioning? {
    switch transitionAnimationType {
    case .systemRotate:
      return SystemRotateAnimator(transitionDuration: transitionDuration)
    case .systemSuckEffect:
      return SystemSuckEffectAnimator(transitionDuration: transitionDuration)
    case .systemRippleEffect:
      return SystemRippleEffectAnimator(transitionDuration: transitionDuration)
    case let .explode(xFactor, minAngle, maxAngle):
      return ExplodeAnimator(xFactor: xFactor, minAngle: minAngle, maxAngle: maxAngle, transitionDuration: transitionDuration)
    case let .fade(direction):
      return FadeAnimator(direction: direction, transitionDuration: transitionDuration)
    case let .fold(direction, folds):
      return FoldAnimator(from: direction, folds: folds, transitionDuration: transitionDuration)
    case let .portal(direction, zoomScale):
      return PortalAnimator(from: direction, zoomScale: zoomScale, transitionDuration: transitionDuration)
    case let .natGeo(direction):
      return NatGeoAnimator(from: direction, transitionDuration: transitionDuration)
    case let .turn(direction):
      return TurnAnimator(from: direction, transitionDuration: transitionDuration)
    case let .cards(direction):
      return CardsAnimator(from: direction, transitionDuration: transitionDuration)
    case let .flip(direction):
      return FlipAnimator(from: direction, transitionDuration: transitionDuration)
    case let .slide(direction, isFade):
      return SlideAnimator(from: direction, isFade: isFade, transitionDuration: transitionDuration)
    case let .systemCube(direction):
      return SystemCubeAnimator(from: direction, transitionDuration: transitionDuration)
    case let .systemFlip(direction):
      return SystemFlipAnimator(from: direction, transitionDuration: transitionDuration)
    case let .systemMoveIn(direction):
      return SystemMoveInAnimator(from: direction, transitionDuration: transitionDuration)
    case let .systemPush(direction):
      return SystemPushAnimator(from: direction, transitionDuration: transitionDuration)
    case let .systemReveal(direction):
      return SystemRevealAnimator(from: direction, transitionDuration: transitionDuration)
    case let .systemPage(type):
      return SystemPageAnimator(type: type, transitionDuration: transitionDuration)
    case let .systemCameraIris(hollowState):
      return SystemCameraIrisAnimator(hollowState: hollowState, transitionDuration: transitionDuration)
    default:
      return nil
    }
  }

  public static func makeAnimator(presentationAnimationType: PresentationAnimationType, transitionDuration: Duration = defaultPresentationDuration) -> AnimatedPresenting {
    switch presentationAnimationType {
    case let .cover(direction):
      return CoverAnimator(from: direction, transitionDuration: transitionDuration)
    case .zoom:
      return ZoomAnimator(transitionDuration: transitionDuration)
    case .dropDown:
      return DropDownAnimator(transitionDuration: transitionDuration)
    case .flip, .crossDissolve: // System animation, will never be executed
      fatalError()
    }
  }

}
