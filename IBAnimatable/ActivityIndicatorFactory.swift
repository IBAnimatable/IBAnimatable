//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public struct ActivityIndicatorFactory {
  public static func generateActivityIndicator(activityIndicatorType: ActivityIndicatorType) -> ActivityIndicatorAnimating {
    switch activityIndicatorType {
    case .None:
      fatalError()
    case .AudioEqualizer:
      return ActivityIndicatorAnimationAudioEqualizer()
    case .BallBeat:
      return ActivityIndicatorAnimationBallBeat()
    case .BallClipRotate:
      return ActivityIndicatorAnimationBallClipRotate()
    case .BallClipRotateMultiple:
      return ActivityIndicatorAnimationBallClipRotateMultiple()
    case .BallClipRotatePulse:
      return ActivityIndicatorAnimationBallClipRotatePulse()
    case .BallGridBeat:
      return ActivityIndicatorAnimationBallGridBeat()
    case .BallGridPulse:
      return ActivityIndicatorAnimationBallGridPulse()
    case .BallPulse:
      return ActivityIndicatorAnimationBallPulse()
    case .BallPulseRise:
      return ActivityIndicatorAnimationBallPulseRise()
    case .BallPulseSync:
      return ActivityIndicatorAnimationBallPulseSync()
    case .BallRotate:
      return ActivityIndicatorAnimationBallRotate()
    case .BallRotateChase:
      return ActivityIndicatorAnimationBallRotateChase()
    case .BallScale:
      return ActivityIndicatorAnimationBallScale()
    case .BallScaleMultiple:
      return ActivityIndicatorAnimationBallScaleMultiple()
    case .BallScaleRipple:
      return ActivityIndicatorAnimationBallScaleRipple()
    case .BallScaleRippleMultiple:
      return ActivityIndicatorAnimationBallScaleRippleMultiple()
    case .BallSpinFadeLoader:
      return ActivityIndicatorAnimationBallSpinFadeLoader()
    case .BallTrianglePath:
      return ActivityIndicatorAnimationBallTrianglePath()
    case .BallZigZag:
      return ActivityIndicatorAnimationBallZigZag()
    case .BallZigZagDeflect:
      return ActivityIndicatorAnimationBallZigZagDeflect()
    case .CubeTransition:
      return ActivityIndicatorAnimationCubeTransition()
    case .LineScale:
      return ActivityIndicatorAnimationLineScale()
    case .LineSpinFadeLoader:
      return ActivityIndicatorAnimationLineSpinFadeLoader()
    case .LineScaleParty:
      return ActivityIndicatorAnimationLineScaleParty()
    case .LineScalePulseOut:
      return ActivityIndicatorAnimationLineScalePulseOut()
    case .LineScalePulseOutRapid:
      return ActivityIndicatorAnimationLineScalePulseOutRapid()
    case .Orbit:
      return ActivityIndicatorAnimationOrbit()
    case .Pacman:
      return ActivityIndicatorAnimationPacman()
    case .SemiCircleSpin:
      return ActivityIndicatorAnimationSemiCircleSpin()
    case .SquareSpin:
      return ActivityIndicatorAnimationSquareSpin()
    case .TriangleSkewSpin:
      return ActivityIndicatorAnimationTriangleSkewSpin()
    }
  }
}
