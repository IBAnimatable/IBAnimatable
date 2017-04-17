//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
/**
 Animator Factory
 */
public struct AnimatorFactory {
  public static func makeAnimator(transitionAnimationType: TransitionAnimationType,
                                  transitionDuration: Duration = defaultTransitionDuration) -> AnimatedTransitioning? {
    switch transitionAnimationType {
    case .systemRotate:
      return SystemTransitionAnimator(systemType: .rotate, duration: transitionDuration)
    case .systemSuckEffect:
      return SystemTransitionAnimator(systemType: .suckEffect, duration: transitionDuration)
    case .systemRippleEffect:
      return SystemTransitionAnimator(systemType: .rippleEffect, duration: transitionDuration)
    case let .explode(xFactor, minAngle, maxAngle):
      return ExplodeAnimator(xFactor: xFactor, minAngle: minAngle, maxAngle: maxAngle, duration: transitionDuration)
    case let .fade(direction):
      return FadeAnimator(direction: direction, duration: transitionDuration)
    case let .fold(direction, folds):
      return FoldAnimator(from: direction, folds: folds, duration: transitionDuration)
    case let .portal(direction, zoomScale):
      return PortalAnimator(from: direction, zoomScale: zoomScale, duration: transitionDuration)
    case let .natGeo(direction):
      return NatGeoAnimator(from: direction, duration: transitionDuration)
    case let .turn(direction):
      return TurnAnimator(from: direction, duration: transitionDuration)
    case let .cards(direction):
      return CardsAnimator(from: direction, duration: transitionDuration)
    case let .flip(direction):
      return FlipAnimator(from: direction, duration: transitionDuration)
    case let .slide(direction, isFade):
      return SlideAnimator(from: direction, isFade: isFade, duration: transitionDuration)
    case let .systemCube(direction):
      return SystemTransitionAnimator(systemType: .cube, duration: transitionDuration, direction: direction)
    case let .systemFlip(direction):
      return SystemTransitionAnimator(systemType: .flip, duration: transitionDuration, direction: direction)
    case let .systemMoveIn(direction):
      return SystemTransitionAnimator(systemType: .moveIn, duration: transitionDuration, direction: direction)
    case let .systemPush(direction):
      return SystemTransitionAnimator(systemType: .push, duration: transitionDuration, direction: direction)
    case let .systemReveal(direction):
      return SystemTransitionAnimator(systemType: .reveal, duration: transitionDuration, direction: direction)
    case let .systemPage(type):
      return SystemTransitionAnimator(systemType: TransitionAnimationType.SystemTransitionType(pageType: type), duration: transitionDuration)
    case let .systemCameraIris(hollowState):
    return SystemTransitionAnimator(systemType: TransitionAnimationType.SystemTransitionType(hollowState: hollowState), duration: transitionDuration)
    default:
      return nil
    }
  }

  public static func makeAnimator(presentationAnimationType: PresentationAnimationType,
                                  transitionDuration: Duration = defaultPresentationDuration) -> AnimatedPresenting {
    switch presentationAnimationType {
    case let .cover(direction):
      return CoverAnimator(from: direction, duration: transitionDuration)
    case .zoom:
      return ZoomAnimator(duration: transitionDuration)
    case .dropDown:
      return DropDownAnimator(duration: transitionDuration)
    case .flip, .crossDissolve:
      fatalError("System animation, will never be executed")
    }
  }

}
