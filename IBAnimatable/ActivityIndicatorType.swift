//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public enum ActivityIndicatorType: String {
  case None
  case AudioEqualizer
  case BallBeat
  case BallClipRotate
  case BallClipRotateMultiple
  case BallClipRotatePulse
  case BallGridBeat
  case BallGridPulse
  case BallPulse
  case BallPulseRise
  case BallPulseSync
  case BallRotate
  case BallRotateChase
  case BallScale
  case BallScaleMultiple
  case BallScaleRipple
  case BallScaleRippleMultiple
  case BallSpinFadeLoader
  case BallTrianglePath
  case BallZigZag
  case BallZigZagDeflect
  case CubeTransition
  case LineScale
  case LineScaleParty
  case LineScalePulseOut
  case LineScalePulseOutRapid
  case LineSpinFadeLoader
  case Orbit
  case Pacman
  case SemiCircleSpin
  case SquareSpin
  case TriangleSkewSpin

  public static func fromString(string: String) -> ActivityIndicatorType {
    switch string {
    case "AudioEqualizer": return .AudioEqualizer
    case "BallBeat": return .BallBeat
    case "BallClipRotate": return .BallClipRotate
    case "BallClipRotateMultiple": return .BallClipRotateMultiple
    case "BallClipRotatePulse": return .BallClipRotatePulse
    case "BallGridBeat": return .BallGridBeat
    case "BallGridPulse": return .BallGridPulse
    case "BallPulse": return .BallPulse
    case "BallPulseRise": return .BallPulseRise
    case "BallPulseSync": return .BallPulseSync
    case "BallRotate": return .BallRotate
    case "BallRotateChase": return .BallRotateChase
    case "BallScale": return .BallScale
    case "BallScaleMultiple": return .BallScaleMultiple
    case "BallScaleRipple": return .BallScaleRipple
    case "BallScaleRippleMultiple": return .BallScaleRippleMultiple
    case "BallSpinFadeLoader": return .BallSpinFadeLoader
    case "BallTrianglePath": return .BallTrianglePath
    case "BallZigZag": return .BallZigZag
    case "BallZigZagDeflect": return .BallZigZagDeflect
    case "CubeTransition": return .CubeTransition
    case "LineScale": return .LineScale
    case "LineSpinFadeLoader": return .LineSpinFadeLoader
    case "LineScaleParty": return .LineScaleParty
    case "LineScalePulseOut": return .LineScalePulseOut
    case "LineScalePulseOutRapid": return .LineScalePulseOutRapid
    case "Orbit": return .Orbit
    case "Pacman": return .Pacman
    case "SemiCircleSpin": return .SemiCircleSpin
    case "SquareSpin": return .SquareSpin
    case "TriangleSkewSpin": return .TriangleSkewSpin
    default: return .None
    }    
  }

}
