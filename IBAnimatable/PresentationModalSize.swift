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

extension PresentationModalSize {

  public static func fromString(size: String) -> PresentationModalSize {
    if size.hasPrefix("Half") {
      return .Half
    } else if size.hasPrefix("Full") {
      return .Full
    }
    return fromStringWithParameters(size)
  }


  static func fromStringWithParameters(size: String) -> PresentationModalSize {
    let sizeParams = params(forSize: size)
    guard let value = Float(sizeParams.first ?? "") else {
      return .Half
    }

    if size.hasPrefix("Custom") {
      return .Custom(size: value)
    }
    return .Half
  }

}

private extension PresentationModalSize {

  static func params(forSize size: String) -> [String] {
    let range = size.rangeOfString("(")
    let size = size.stringByReplacingOccurrencesOfString(" ", withString: "")
      .lowercaseString
      .substringFromIndex(range?.startIndex ?? size.endIndex)
      .stringByReplacingOccurrencesOfString("(", withString: "")
      .stringByReplacingOccurrencesOfString(")", withString: "")
    return size.componentsSeparatedByString(",")
  }
  
}
