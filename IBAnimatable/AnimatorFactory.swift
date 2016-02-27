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
    case .Fade:
      return FadeAnimator(fadeType: .Fade, transitionDuration: transitionDuration)
    case .FadeIn:
      return FadeAnimator(fadeType: .FadeIn, transitionDuration: transitionDuration)
    case .FadeOut:
      return FadeAnimator(fadeType: .FadeOut, transitionDuration: transitionDuration)
    case .CubeFromLeft:
      return SystemCubeAnimator(fromDirection: .FromLeft, transitionDuration: transitionDuration)
    case .CubeFromRight:
      return SystemCubeAnimator(fromDirection: .FromRight, transitionDuration: transitionDuration)
    case .CubeFromTop:
      return SystemCubeAnimator(fromDirection: .FromTop, transitionDuration: transitionDuration)
    case .CubeFromBottom:
      return SystemCubeAnimator(fromDirection: .FromBottom, transitionDuration: transitionDuration)
    case .FlipFromLeft:
      return SystemFlipAnimator(fromDirection: .FromLeft, transitionDuration: transitionDuration)
    case .FlipFromRight:
      return SystemFlipAnimator(fromDirection: .FromRight, transitionDuration: transitionDuration)
    case .FlipFromTop:
      return SystemFlipAnimator(fromDirection: .FromTop, transitionDuration: transitionDuration)
    case .FlipFromBottom:
      return SystemFlipAnimator(fromDirection: .FromBottom, transitionDuration: transitionDuration)
    }
  }
}
