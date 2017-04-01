//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public struct ActivityIndicatorFactory {
  public static func makeActivityIndicator(activityIndicatorType: ActivityIndicatorType) -> ActivityIndicatorAnimating {
    switch activityIndicatorType {
    case .none:
      fatalError("Invalid ActivityIndicatorAnimating")
    case .audioEqualizer:
      return ActivityIndicatorAnimationAudioEqualizer()
    case .ballBeat:
      return ActivityIndicatorAnimationBallBeat()
    case .ballClipRotate:
      return ActivityIndicatorAnimationBallClipRotate()
    case .ballClipRotateMultiple:
      return ActivityIndicatorAnimationBallClipRotateMultiple()
    case .ballClipRotatePulse:
      return ActivityIndicatorAnimationBallClipRotatePulse()
    case .ballGridBeat:
      return ActivityIndicatorAnimationBallGridBeat()
    case .ballGridPulse:
      return ActivityIndicatorAnimationBallGridPulse()
    case .ballPulse:
      return ActivityIndicatorAnimationBallPulse()
    case .ballPulseRise:
      return ActivityIndicatorAnimationBallPulseRise()
    case .ballPulseSync:
      return ActivityIndicatorAnimationBallPulseSync()
    case .ballRotate:
      return ActivityIndicatorAnimationBallRotate()
    case .ballRotateChase:
      return ActivityIndicatorAnimationBallRotateChase()
    case .ballScale:
      return ActivityIndicatorAnimationBallScale()
    case .ballScaleMultiple:
      return ActivityIndicatorAnimationBallScaleMultiple()
    case .ballScaleRipple:
      return ActivityIndicatorAnimationBallScaleRipple()
    case .ballScaleRippleMultiple:
      return ActivityIndicatorAnimationBallScaleRippleMultiple()
    case .ballSpinFadeLoader:
      return ActivityIndicatorAnimationBallSpinFadeLoader()
    case .ballTrianglePath:
      return ActivityIndicatorAnimationBallTrianglePath()
    case .ballZigZag:
      return ActivityIndicatorAnimationBallZigZag()
    case .ballZigZagDeflect:
      return ActivityIndicatorAnimationBallZigZagDeflect()
    case .cubeTransition:
      return ActivityIndicatorAnimationCubeTransition()
    case .lineScale:
      return ActivityIndicatorAnimationLineScale()
    case .lineSpinFadeLoader:
      return ActivityIndicatorAnimationLineSpinFadeLoader()
    case .lineScaleParty:
      return ActivityIndicatorAnimationLineScaleParty()
    case .lineScalePulseOut:
      return ActivityIndicatorAnimationLineScalePulseOut()
    case .lineScalePulseOutRapid:
      return ActivityIndicatorAnimationLineScalePulseOutRapid()
    case .orbit:
      return ActivityIndicatorAnimationOrbit()
    case .pacman:
      return ActivityIndicatorAnimationPacman()
    case .semiCircleSpin:
      return ActivityIndicatorAnimationSemiCircleSpin()
    case .squareSpin:
      return ActivityIndicatorAnimationSquareSpin()
    case .triangleSkewSpin:
      return ActivityIndicatorAnimationTriangleSkewSpin()
    }
  }
}
