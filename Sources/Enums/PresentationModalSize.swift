//
//  Created by Tom Baranes on 17/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public enum PresentationModalSize: IBEnum {

  case half
  case full
  case custom(size: Float)

  func width(parentSize: CGSize) -> Float {
    switch self {
    case .half:
      return floorf(Float(parentSize.width) / 2.0)
    case .full:
      return Float(parentSize.width)
    case .custom(let size):
      return size
    }
  }

  func height(parentSize: CGSize) -> Float {

  switch self {
    case .half:
      return floorf(Float(parentSize.height) / 2.0)
    case .full:
      return Float(parentSize.height)
    case .custom(let size):
      return size
    }
  }

}

public extension PresentationModalSize {
  init?(string: String?) {
    guard let string = string else {
      return nil
    }

    let (name, params) = PresentationModalSize.extractNameAndParams(from: string)
    switch name {
      case "half":
      self = .half
      case "full":
      self = .full
      case "custom" where params.count == 1:
        self = .custom(size: params[0].toFloat() ?? 0)
    default:
      return nil
    }
  }
}
