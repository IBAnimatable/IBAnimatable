//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Predefined Transition Animation Type
 */
public enum PresentationAnimationType: IBEnum {
  case flip
  case crossDissolve
  case cover(from: TransitionAnimationType.Direction)
  case zoom
  case dropDown

  public var stringValue: String {
    return String(describing: self)
  }

  public var systemTransition: UIModalTransitionStyle? {
    switch self {
    case .crossDissolve: return .crossDissolve
    case .flip: return .flipHorizontal
    case .cover(from: .bottom): return .coverVertical
    default: return nil
    }
  }

  public init?(string: String?) {
    guard let string = string else {
      return nil
    }

    let (name, params) = MaskType.extractNameAndParams(from: string)
    switch name {
    case "crossdissolve":
      self = .crossDissolve
    case "flip":
      self = .flip
    case "zoom":
      self = .zoom
    case "dropdown":
      self = .dropDown
    case "cover":
      self = .cover(from: TransitionAnimationType.Direction.fromString(forParams: params) ?? .bottom)
    default:
      return nil
    }
  }

}

extension PresentationAnimationType: Hashable {
  public var hashValue: Int {
    return stringValue.hashValue
  }

  public static func == (lhs: PresentationAnimationType, rhs: PresentationAnimationType) -> Bool {
    return lhs.stringValue == rhs.stringValue
  }
}
