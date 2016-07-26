//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation

/**
 Predefined Transition Animation Type
 */
public enum TransitionAnimationType {
  case SystemRotate
  case SystemSuckEffect
  case SystemRippleEffect
  case Explode(params: [String])
  case Fade(direction: TransitionDirection)
  case Fold(fromDirection: TransitionDirection, params: [String])
  case Portal(direction: TransitionDirection, params: [String])
  case Slide(toDirection: TransitionDirection, params: [String])
  case NatGeo(toDirection: TransitionDirection)
  case Turn(fromDirection: TransitionDirection)
  case Cards(direction: TransitionDirection)
  case Flip(fromDirection: TransitionDirection)
  case SystemCube(fromDirection: TransitionDirection)
  case SystemFlip(fromDirection: TransitionDirection)
  case SystemMoveIn(fromDirection: TransitionDirection)
  case SystemPush(fromDirection: TransitionDirection)
  case SystemReveal(fromDirection: TransitionDirection)
  case SystemPage(type: TransitionPageType)
  case SystemCameraIris(hollowState: TransitionHollowState)
  
  public var stringValue: String {
    return String(self)
  }

  public static func fromString(transitionType: String) -> TransitionAnimationType? {
    if transitionType.hasPrefix("SystemRippleEffect") {
      return .SystemRippleEffect
    } else if transitionType.hasPrefix("SystemSuckEffect") {
        return .SystemSuckEffect
    } else if transitionType.hasPrefix("Explode") {
      return .Explode(params: params(forTransitionType: transitionType))
    } else if transitionType.hasPrefix("Fade") {
      return fadeTransitionAnimationType(transitionType)
    } else if transitionType.hasPrefix("SystemCameraIris") {
        return cameraIrisTransitionAnimationType(transitionType)
    } else if transitionType.hasPrefix("SystemPage") {
      return pageTransitionAnimationType(transitionType)
    } else if transitionType.hasPrefix("SystemRotate") {
      return .SystemRotate
    } else {
      return fromStringWithDirection(transitionType)
    }
  }

}

// MARK: - TransitionAnimationType from string

private extension TransitionAnimationType {
  
  static func fadeTransitionAnimationType(transitionType: String) -> TransitionAnimationType {
    let transitionParams = params(forTransitionType: transitionType)
    if transitionParams.contains("in") {
      return .Fade(direction: .In)
    } else if transitionParams.contains("out") {
      return .Fade(direction: .Out)
    }
    return .Fade(direction: .Cross)
  }
 
  static func cameraIrisTransitionAnimationType(transitionType: String) -> TransitionAnimationType? {
    let transitionParams = params(forTransitionType: transitionType)
    if transitionParams.contains("hollowopen") {
      return .SystemCameraIris(hollowState: .Open)
    } else if transitionParams.contains("hollowclose") {
      return .SystemCameraIris(hollowState: .Close)
    }
    return .SystemCameraIris(hollowState: .None)
  }
  
  static func pageTransitionAnimationType(transitionType: String) -> TransitionAnimationType? {
    let transitionParams = params(forTransitionType: transitionType)
    if transitionParams.contains("uncurl") {
      return .SystemPage(type: .UnCurl)
    } else if transitionParams.contains("curl") {
      return .SystemPage(type: .Curl)      
    }
    return nil
  }
  
  static func fromStringWithDirection(transitionType: String) -> TransitionAnimationType? {
    let transitionParams = params(forTransitionType: transitionType)
    let direction = transitionDirection(forParams: transitionParams) ?? .Left
    if transitionType.hasPrefix("SystemCube") {
      return .SystemCube(fromDirection: direction)
    } else if transitionType.hasPrefix("SystemFlip") {
      return .SystemFlip(fromDirection: direction)
    } else if transitionType.hasPrefix("SystemMoveIn") {
      return .SystemMoveIn(fromDirection: direction)
    } else if transitionType.hasPrefix("SystemPush") {
      return .SystemPush(fromDirection: direction)
    } else if transitionType.hasPrefix("SystemReveal") {
      return .SystemReveal(fromDirection: direction)
    } else if transitionType.hasPrefix("NatGeo") {
      return .NatGeo(toDirection: direction)
    } else if transitionType.hasPrefix("Turn") {
      return .Turn(fromDirection: direction)      
    } else if transitionType.hasPrefix("Cards") {
      return .Cards(direction: direction)
    } else if transitionType.hasPrefix("Flip") {
      return .Flip(fromDirection: direction)
    } else {
      return fromStringWithDirectionAndParams(transitionType, direction: direction, params: transitionParams)
    }
  }
  
  static func fromStringWithDirectionAndParams(transitionType: String, direction: TransitionDirection, params: [String]) -> TransitionAnimationType? {
    var params = params
    params.removeFirst()
    if transitionType.hasPrefix("Fold") {
      return .Fold(fromDirection: direction, params: params)
    } else if transitionType.hasPrefix("Portal") {
      return .Portal(direction: direction, params: params)
    } else if transitionType.hasPrefix("Slide") {
      return .Slide(toDirection: direction, params: params)
    }
    return nil
  }
}

// MARK: - Helpers

private extension TransitionAnimationType {
  
  static func params(forTransitionType transitionType: String) -> [String] {
    let range = transitionType.rangeOfString("(")
    let transitionType = transitionType.stringByReplacingOccurrencesOfString(" ", withString: "")
      .lowercaseString
      .substringFromIndex(range?.startIndex ?? transitionType.endIndex)
      .stringByReplacingOccurrencesOfString("(", withString: "")
      .stringByReplacingOccurrencesOfString(")", withString: "")
    return transitionType.componentsSeparatedByString(",")
  }
  
  static func transitionDirection(forParams params: [String]) -> TransitionDirection? {
    if params.contains("left") {
      return .Left
    } else if params.contains("right") {
      return .Right
    } else if params.contains("top") {
      return .Top
    } else if params.contains("bottom") {
      return .Bottom
    } else if params.contains("forward") {
      return .Forward
    } else if params.contains("backward") {
      return .Backward
    }
    return nil
  }
  
}
