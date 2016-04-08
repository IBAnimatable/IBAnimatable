//
//  Created by Tom Baranes on 02/04/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

public enum TransitionRotateDegree {
  case Ninety
  case NinetyCCW
  case OneHundredHeighty
  case OneHundredHeightyCCW
  
  var stringValue: String {
    switch self {
    case .Ninety:
      return "90"
    case .NinetyCCW:
      return "90ccw"
    case .OneHundredHeighty:
      return "180"
    case .OneHundredHeightyCCW:
      return "180ccw"
    }
  }
}