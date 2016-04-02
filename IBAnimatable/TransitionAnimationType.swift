//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
 Predefined Transition Animation Type
 */
public enum TransitionAnimationType {
  case Fade             // ToView fades in and FromeView fades out
  case FadeIn           // ToView fades in
  case FadeOut          // FromView Fades out
  case SystemSuckEffect
  case SystemRippleEffect
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
    let transitionType = cleanTransitionType(transitionType)
    if transitionType.containsString("hollowopen") {
      return .SystemCameraIris(hollowState: .Open)
    } else if transitionType.containsString("hollowclose") {
      return .SystemCameraIris(hollowState: .Close)
    }
    return .SystemCameraIris(hollowState: .None)
  }
  
  static func pageTransitionAnimationType(transitionType: String) -> TransitionAnimationType? {
    let transitionType = cleanTransitionType(transitionType)
    if transitionType.containsString("uncurl") {
      return .SystemPage(type: .UnCurl)
    } else if transitionType.containsString("curl") {
      return .SystemPage(type: .Curl)      
    }
    return nil
  }
  
  static func rotateTransitionAnimationType(transitionType: String) -> TransitionAnimationType? {
    let transitionType = cleanTransitionType(transitionType)
    if transitionType.containsString("90ccw") || transitionType.containsString("ninetyccw") {
      return .SystemRotate(degree: .NinetyCCW)
    } else if transitionType.containsString("90") || transitionType.containsString("ninety") {
      return .SystemRotate(degree: .Ninety)
    } else if transitionType.containsString("180ccw") || transitionType.containsString("OneHundredHeightyccw") {
      return .SystemRotate(degree: .OneHundredHeightyCCW)
    } else if transitionType.containsString("180") || transitionType.containsString("OneHundredHeighty") {
      return .SystemRotate(degree: .OneHundredHeighty)
    }
    return nil
  }
  
  static func fromStringWithDirection(transitionType: String) -> TransitionAnimationType? {
    guard let direction = transitionDirection(forTransitionType: transitionType) else {
      return nil
    }
    
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
    }
    return nil
  }
  
}

// MARK: - Helpers

private extension TransitionAnimationType {
  
  static func cleanTransitionType(transitionType: String) -> String {
    let range = transitionType.rangeOfString("(")
    let transitionType = transitionType.stringByReplacingOccurrencesOfString(" ", withString: "")
      .lowercaseString
      .substringFromIndex(range?.startIndex ?? transitionType.endIndex)
    return transitionType
  }
  
  static func transitionDirection(forTransitionType transitionType: String) -> TransitionFromDirection? {
    let transitionType = cleanTransitionType(transitionType)
    if transitionType.containsString("left") {
      return .Left
    } else if transitionType.containsString("right") {
      return .Right
    } else if transitionType.containsString("top") {
      return .Top
    } else if transitionType.containsString("bottom") {
      return .Bottom
    }
    return nil
  }
  
}