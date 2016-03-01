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
    case .SystemCubeFromLeft:
      return SystemCubeAnimator(fromDirection: .FromLeft, transitionDuration: transitionDuration)
    case .SystemCubeFromRight:
      return SystemCubeAnimator(fromDirection: .FromRight, transitionDuration: transitionDuration)
    case .SystemCubeFromTop:
      return SystemCubeAnimator(fromDirection: .FromTop, transitionDuration: transitionDuration)
    case .SystemCubeFromBottom:
      return SystemCubeAnimator(fromDirection: .FromBottom, transitionDuration: transitionDuration)
    case .SystemFlipFromLeft:
      return SystemFlipAnimator(fromDirection: .FromLeft, transitionDuration: transitionDuration)
    case .SystemFlipFromRight:
      return SystemFlipAnimator(fromDirection: .FromRight, transitionDuration: transitionDuration)
    case .SystemFlipFromTop:
      return SystemFlipAnimator(fromDirection: .FromTop, transitionDuration: transitionDuration)
    case .SystemFlipFromBottom:
      return SystemFlipAnimator(fromDirection: .FromBottom, transitionDuration: transitionDuration)
    }
  }
}
