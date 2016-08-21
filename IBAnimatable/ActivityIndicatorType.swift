//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public enum ActivityIndicatorType: String {
  case None
  case BallBeat

  public static func fromString(string: String) -> ActivityIndicatorType {
    if string.hasPrefix("BallBeat") {
      return ActivityIndicatorType.BallBeat
    }
    return None
  }

}
