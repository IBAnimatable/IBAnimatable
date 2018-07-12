//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

/// Activity indicator type: used to specify the animation for the activity indicator.
public enum ActivityIndicatorType: String, IBEnum {
  case none
  case audioEqualizer
  case ballBeat
  case ballClipRotate
  case ballClipRotateMultiple
  case ballClipRotatePulse
  case ballGridBeat
  case ballGridPulse
  case ballPulse
  case ballPulseRise
  case ballPulseSync
  case ballRotate
  case ballRotateChase
  case ballScale
  case ballScaleMultiple
  case ballScaleRipple
  case ballScaleRippleMultiple
  case ballSpinFadeLoader
  case ballTrianglePath
  case ballZigZag
  case ballZigZagDeflect
  case cubeTransition
  case lineScale
  case lineScaleParty
  case lineScalePulseOut
  case lineScalePulseOutRapid
  case lineSpinFadeLoader
  case orbit
  case pacman
  case semiCircleSpin
  case squareSpin
  case triangleSkewSpin
  case circleStrokeSpin
  case circleDashStrokeSpin
  case gear
  case tripleGear
  case heartBeat
  case triforce
  case rupee
  case newtonCradle
  case circlePendulum
}

#if swift(>=4.2)
extension ActivityIndicatorType: CaseIterable {}
#endif
