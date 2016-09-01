//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/**
 Predefined Transition Animation Type
 */
public enum PresentationAnimationType {
  case flip
  case crossDissolve
  case cover(fromDirection: TransitionDirection)
  case zoom
  case dropDown

  public var stringValue: String {
    return String(describing: self)
  }

  public var systemTransition: UIModalTransitionStyle? {
    switch self {
    case .crossDissolve: return .crossDissolve
    case .flip: return .flipHorizontal
    case .cover(fromDirection: .bottom): return .coverVertical
    default: return nil
    }
  }

  public static func fromString(transitionType: String) -> PresentationAnimationType? {
    if transitionType.hasPrefix("CrossDissolve") {
      return .crossDissolve
    } else if transitionType.hasPrefix("Flip") {
      return .flip
    } else if transitionType.hasPrefix("Zoom") {
      return .zoom
    } else if transitionType.hasPrefix("DropDown") {
      return .dropDown
    }
    return fromStringWithDirection(presentationType: transitionType)
  }

}

// MARK: - PresentationAnimationType from string

private extension PresentationAnimationType {

  static func fromStringWithDirection(presentationType: String) -> PresentationAnimationType? {
    let transitionParams = params(forTransitionType: presentationType)
    let direction = TransitionDirection.fromString(forParams: transitionParams) ?? .left
    if presentationType.hasPrefix("Cover") {
      return .cover(fromDirection: direction)
    } else {
      return fromStringWithDirectionAndParams(presentationType: presentationType, direction: direction, params: transitionParams)
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
    let range = transitionType.range(of: "(")
    let transitionType = transitionType.replacingOccurrences(of: " ", with: "").lowercased()
      .substring(from: range?.lowerBound ?? transitionType.endIndex)
      .replacingOccurrences(of: "(", with: "")
      .replacingOccurrences(of: ")", with: "")
      .capitalized
    return transitionType.components(separatedBy: ",")
  }

}
