//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
 Predefined Transition Animation Type
 */
public enum TransitionAnimationType {
  case systemRotate
  case systemSuckEffect
  case systemRippleEffect
  case explode(params: [String])
  case fade(direction: TransitionDirection)
  case fold(fromDirection: TransitionDirection, params: [String])
  case portal(direction: TransitionDirection, params: [String])
  case slide(toDirection: TransitionDirection, params: [String])
  case natGeo(toDirection: TransitionDirection)
  case turn(fromDirection: TransitionDirection)
  case cards(direction: TransitionDirection)
  case flip(fromDirection: TransitionDirection)
  case systemCube(fromDirection: TransitionDirection)
  case systemFlip(fromDirection: TransitionDirection)
  case systemMoveIn(fromDirection: TransitionDirection)
  case systemPush(fromDirection: TransitionDirection)
  case systemReveal(fromDirection: TransitionDirection)
  case systemPage(type: TransitionPageType)
  case systemCameraIris(hollowState: TransitionHollowState)
  
  public var stringValue: String {
    return String(self)
  }

  public static func fromString(_ transitionType: String) -> TransitionAnimationType? {
    if transitionType.hasPrefix("SystemRippleEffect") {
      return .systemRippleEffect
    } else if transitionType.hasPrefix("SystemSuckEffect") {
        return .systemSuckEffect
    } else if transitionType.hasPrefix("Explode") {
      return .explode(params: params(forTransitionType: transitionType))
    } else if transitionType.hasPrefix("Fade") {
      return fadeTransitionAnimationType(transitionType)
    } else if transitionType.hasPrefix("SystemCameraIris") {
        return cameraIrisTransitionAnimationType(transitionType)
    } else if transitionType.hasPrefix("SystemPage") {
      return pageTransitionAnimationType(transitionType)
    } else if transitionType.hasPrefix("SystemRotate") {
      return .systemRotate
    } else {
      return fromStringWithDirection(transitionType)
    }
  }

}

// MARK: - TransitionAnimationType from string

private extension TransitionAnimationType {
  
  static func fadeTransitionAnimationType(_ transitionType: String) -> TransitionAnimationType {
    let transitionParams = params(forTransitionType: transitionType)
    if transitionParams.contains("in") {
      return .fade(direction: .in)
    } else if transitionParams.contains("out") {
      return .fade(direction: .out)
    }
    return .fade(direction: .cross)
  }
 
  static func cameraIrisTransitionAnimationType(_ transitionType: String) -> TransitionAnimationType? {
    let transitionParams = params(forTransitionType: transitionType)
    if transitionParams.contains("hollowopen") {
      return .systemCameraIris(hollowState: .open)
    } else if transitionParams.contains("hollowclose") {
      return .systemCameraIris(hollowState: .close)
    }
    return .systemCameraIris(hollowState: .none)
  }
  
  static func pageTransitionAnimationType(_ transitionType: String) -> TransitionAnimationType? {
    let transitionParams = params(forTransitionType: transitionType)
    if transitionParams.contains("uncurl") {
      return .systemPage(type: .unCurl)
    } else if transitionParams.contains("curl") {
      return .systemPage(type: .curl)      
    }
    return nil
  }
  
  static func fromStringWithDirection(_ transitionType: String) -> TransitionAnimationType? {
    let transitionParams = params(forTransitionType: transitionType)
    let direction = transitionDirection(forParams: transitionParams) ?? .left
    if transitionType.hasPrefix("SystemCube") {
      return .systemCube(fromDirection: direction)
    } else if transitionType.hasPrefix("SystemFlip") {
      return .systemFlip(fromDirection: direction)
    } else if transitionType.hasPrefix("SystemMoveIn") {
      return .systemMoveIn(fromDirection: direction)
    } else if transitionType.hasPrefix("SystemPush") {
      return .systemPush(fromDirection: direction)
    } else if transitionType.hasPrefix("SystemReveal") {
      return .systemReveal(fromDirection: direction)
    } else if transitionType.hasPrefix("NatGeo") {
      return .natGeo(toDirection: direction)
    } else if transitionType.hasPrefix("Turn") {
      return .turn(fromDirection: direction)      
    } else if transitionType.hasPrefix("Cards") {
      return .cards(direction: direction)
    } else if transitionType.hasPrefix("Flip") {
      return .flip(fromDirection: direction)
    } else {
      return fromStringWithDirectionAndParams(transitionType, direction: direction, params: transitionParams)
    }
  }
  
  static func fromStringWithDirectionAndParams(_ transitionType: String, direction: TransitionDirection, params: [String]) -> TransitionAnimationType? {
    var params = params
    params.removeFirst()
    if transitionType.hasPrefix("Fold") {
      return .fold(fromDirection: direction, params: params)
    } else if transitionType.hasPrefix("Portal") {
      return .portal(direction: direction, params: params)
    } else if transitionType.hasPrefix("Slide") {
      return .slide(toDirection: direction, params: params)
    }
    return nil
  }
}

// MARK: - Helpers

private extension TransitionAnimationType {
  
  static func params(forTransitionType transitionType: String) -> [String] {
    let range = transitionType.range(of: "(")
    let transitionType = transitionType.replacingOccurrences(of: " ", with: "").lowercased()
      .substring(from: range?.lowerBound ?? transitionType.endIndex)
      .replacingOccurrences(of: "(", with: "")
      .replacingOccurrences(of: ")", with: "")
    return transitionType.components(separatedBy: ",")
  }
  
  static func transitionDirection(forParams params: [String]) -> TransitionDirection? {
    if params.contains("left") {
      return .left
    } else if params.contains("right") {
      return .right
    } else if params.contains("top") {
      return .top
    } else if params.contains("bottom") {
      return .bottom
    } else if params.contains("forward") {
      return .forward
    } else if params.contains("backward") {
      return .backward
    }
    return nil
  }
  
}
