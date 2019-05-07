//
//  Created by Tom Baranes on 17/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public enum PresentationModalSize: IBEnum {

  case half
  case full
  case third
  case quarter
  case fifth
  case sixth
  case seventh
  case eighth
  case threeQuarters
  case twoThirds
  case goldenSmall
  case goldenLarge
  case custom(size: Float)
  case preferred

  func width(parentSize: CGSize) -> Float {
    return size(for: Float(parentSize.width))
  }

  func height(parentSize: CGSize) -> Float {
    return size(for: Float(parentSize.height))
  }

  public static let `default`: PresentationModalSize = .half

  private func size(for value: Float) -> Float {
    switch self {
    case .half:
      return floorf(value / 2.0)
    case .full:
      return value
    case  .third:
      return floorf(value / 3.0)
    case  .quarter:
      return floorf(value / 4.0)
    case  .fifth:
      return floorf(value / 5.0)
    case  .sixth:
      return floorf(value / 6.0)
    case  .seventh:
      return floorf(value / 7.0)
    case .eighth:
      return floorf(value / 8.0)
    case .threeQuarters:
      return floorf(3.0 * value / 4.0)
    case .twoThirds:
      return floorf(2.0 * value / 3.0)
    case .goldenSmall:
      return floorf(value - value / goldenRatio)
    case .goldenLarge:
      return floorf(value / goldenRatio)
    case .custom(let size):
      return size
    case .preferred:
      return PresentationModalSize.default.size(for: value)
    }
  }

}

private let goldenRatio: Float = (1.0 + CoreFoundation.sqrt(5.0)) / 2.0

public extension PresentationModalSize {
  init?(string: String?) {
    guard let string = string else {
      return nil
    }
    guard let (name, params) = string.extractNameAndParams() else {
      return nil
    }
    switch name {
    case "half":
      self = .half
    case "full":
      self = .full
    case "third":
      self = .third
    case "quarter":
      self = .quarter
    case "fifth":
      self = .fifth
    case "sixth":
      self = .sixth
    case "seventh":
      self = .seventh
    case "eighth":
      self = .eighth
    case "threequarters":
      self = .threeQuarters
    case "twothirds":
      self = .twoThirds
    case "goldensmall":
      self = .goldenSmall
    case "goldenlarge", "goldenratio":
      self = .goldenLarge
    case "custom" where params.count == 1:
      self = .custom(size: params.toFloat(0) ?? 0)
    case "preferred":
      self = .preferred
    default:
      return nil
    }
  }
}
