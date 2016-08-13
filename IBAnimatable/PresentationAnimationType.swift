//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Predefined Transition Animation Type
 */
public enum PresentationAnimationType {
  case Flip
  case CrossDissolve
  case Cover(fromDirection: TransitionDirection)
  case Zoom
  case DropDown

  public var stringValue: String {
    return String(self)
  }

  public var systemTransition: UIModalTransitionStyle? {
    switch self {
    case .CrossDissolve: return .CrossDissolve
    case .Flip: return .FlipHorizontal
    case .Cover(fromDirection: .Bottom): return .CoverVertical
    default: return nil
    }
  }

  public static func fromString(transitionType: String) -> PresentationAnimationType? {
    if transitionType.hasPrefix("CrossDissolve") {
      return .CrossDissolve
    } else if transitionType.hasPrefix("Flip") {
      return .Flip
    } else if transitionType.hasPrefix("Zoom") {
      return .Zoom
    } else if transitionType.hasPrefix("DropDown") {
      return .DropDown
    }
    return fromStringWithDirection(transitionType)
  }

}

// MARK: - PresentationAnimationType from string

private extension PresentationAnimationType {

  static func fromStringWithDirection(presentationType: String) -> PresentationAnimationType? {
    let transitionParams = params(forTransitionType: presentationType)
    let direction = TransitionDirection.fromString(forParams: transitionParams) ?? .Left
    if presentationType.hasPrefix("Cover") {
      return .Cover(fromDirection: direction)
    } else {
      return fromStringWithDirectionAndParams(presentationType, direction: direction, params: transitionParams)
    }
  }

  static func fromStringWithDirectionAndParams(presentationType: String, direction: TransitionDirection, params: [String]) -> PresentationAnimationType? {
    var params = params
    params.removeFirst()    
    return nil
  }
}

// MARK: - Helpers

private extension PresentationAnimationType {

  static func params(forTransitionType transitionType: String) -> [String] {
    let range = transitionType.rangeOfString("(")
    let transitionType = transitionType.stringByReplacingOccurrencesOfString(" ", withString: "")
      .lowercaseString
      .substringFromIndex(range?.startIndex ?? transitionType.endIndex)
      .stringByReplacingOccurrencesOfString("(", withString: "")
      .stringByReplacingOccurrencesOfString(")", withString: "")
    return transitionType.componentsSeparatedByString(",")
  }

}
