//
//  Created by Tom Baranes on 17/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public enum PresentationModalSize {

  case Half
  case Full
  case Custom(size: Float)

  func width(parentSize: CGSize) -> Float {
    switch self {
    case .Half:
      return floorf(Float(parentSize.width) / 2.0)
    case .Full:
      return Float(parentSize.width)
    case .Custom(let size):
      return size
    }
  }

  func height(parentSize: CGSize) -> Float {
    switch self {
    case .Half:
      return floorf(Float(parentSize.height) / 2.0)
    case .Full:
      return Float(parentSize.height)
    case .Custom(let size):
      return size
    }
  }

}
