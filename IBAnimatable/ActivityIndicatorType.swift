//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public enum ActivityIndicatorType: String {
  case None
  case BallBeat
  case BallPulseSync
  case LineScalePulseOut

  public static func fromString(string: String) -> ActivityIndicatorType {
    if string.hasPrefix("BallBeat") {
      return ActivityIndicatorType.BallBeat
    } else if string.hasPrefix("BallPulseSync") {
      return ActivityIndicatorType.BallPulseSync
    } else if string.hasPrefix("LineScalePulseOut") {
      return ActivityIndicatorType.LineScalePulseOut
    }
    return None
  }

}
