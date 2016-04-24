//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
 Predefined Transition Animation Type
 */
public enum TransitionAnimationType {
  case Fade             // ToView fades in and FromView fades out
  case FadeIn           // ToView fades in
  case FadeOut          // FromView Fades out
  case SystemSuckEffect
  case SystemRippleEffect
  case Explode(params: [String])
  case Fold(direction: TransitionFromDirection, params: [String])
  case Portal(direction: TransitionFromDirection, params: [String])
  case NatGeo(direction: TransitionFromDirection)
  case SystemCube(direction: TransitionFromDirection)
  case SystemFlip(direction: TransitionFromDirection)
  case SystemMoveIn(direction: TransitionFromDirection)
  case SystemPush(direction: TransitionFromDirection)
  case SystemReveal(direction: TransitionFromDirection)
  case SystemPage(type: TransitionPageType)
  case SystemCameraIris(hollowState: TransitionHollowState)
  case SystemRotate(degree: TransitionRotateDegree)
    
  var stringValue: String {
    return String(self)
  }

  static func fromString(transitionType: String) -> TransitionAnimationType? {
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
      return rotateTransitionAnimationType(transitionType)
    } else  {
      return fromStringWithDirection(transitionType)
    }
  }

}

// MARK: - TransitionAnimationType from string

private extension TransitionAnimationType {
  
  static func fadeTransitionAnimationType(transitionType: String) -> TransitionAnimationType {
    if transitionType.hasSuffix("In") {
      return .FadeIn
    } else if transitionType.hasSuffix("Out") {
      return .FadeOut
    }
    return .Fade
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
  
  static func rotateTransitionAnimationType(transitionType: String) -> TransitionAnimationType? {
    let transitionParams = params(forTransitionType: transitionType)
    if transitionParams.contains("90ccw") || transitionParams.contains("ninetyccw") {
      return .SystemRotate(degree: .NinetyCCW)
    } else if transitionParams.contains("90") || transitionParams.contains("ninety") {
      return .SystemRotate(degree: .Ninety)
    } else if transitionParams.contains("180ccw") || transitionParams.contains("onehundredheightyccw") {
      return .SystemRotate(degree: .OneHundredHeightyCCW)
    } else if transitionParams.contains("180") || transitionParams.contains("onehundredheighty") {
      return .SystemRotate(degree: .OneHundredHeighty)
    }
    return nil
  }
  
  static func fromStringWithDirection(transitionType: String) -> TransitionAnimationType? {
    let transitionParams = params(forTransitionType: transitionType)
    let direction = transitionDirection(forParams: transitionParams) ?? .Left
    if transitionType.hasPrefix("SystemCube") {
      return .SystemCube(direction: direction)
    } else if transitionType.hasPrefix("SystemFlip") {
      return .SystemFlip(direction: direction)
    } else if transitionType.hasPrefix("SystemMoveIn") {
      return .SystemMoveIn(direction: direction)
    } else if transitionType.hasPrefix("SystemPush") {
      return .SystemPush(direction: direction)
    } else if transitionType.hasPrefix("SystemReveal") {
      return .SystemReveal(direction: direction)
    } else if transitionType.hasPrefix("NatGeo") {
        return .NatGeo(direction: direction)
    } else {
      return fromStringWithDirectionAndParams(transitionType, direction: direction, params: transitionParams)
    }
  }
  
  static func fromStringWithDirectionAndParams(transitionType: String, direction: TransitionFromDirection, params: [String]) -> TransitionAnimationType? {
    var params = params
    params.removeFirst()
    if transitionType.hasPrefix("Fold") {
      return .Fold(direction: direction, params: params)
    } else if transitionType.hasPrefix("Portal") {
      return .Portal(direction: direction, params: params)
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
  
  static func transitionDirection(forParams params: [String]) -> TransitionFromDirection? {
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
