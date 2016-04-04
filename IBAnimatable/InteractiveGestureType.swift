//
//  Created by Jake Lin on 3/3/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
 The interactive gesture type
 */
public enum InteractiveGestureType {
  case Default          // Will use the default interactive gesture type from `AnimatedTransitioning`
  case Pan(direction: GestureDirection)

  static func fromString(interactiveGestureType: String) -> InteractiveGestureType? {
    if interactiveGestureType.hasPrefix("Default") {
      return .Default
    } else if interactiveGestureType.hasPrefix("Pan") {
      return fromStringWithDirection(interactiveGestureType)
    }
    return nil
  }
}

// MARK: - InteractiveGestureType from string

private extension InteractiveGestureType {
  static func cleanInteractiveGestureType(interactiveGestureType: String) -> String {
    let range = interactiveGestureType.rangeOfString("(")
    let interactiveGestureType = interactiveGestureType.stringByReplacingOccurrencesOfString(" ", withString: "")
      .lowercaseString
      .substringFromIndex(range?.startIndex ?? interactiveGestureType.endIndex)
    return interactiveGestureType
  }
  
  static func interactiveGestureDirection(forInteractiveGestureType interactiveGestureType: String) -> GestureDirection? {
    let interactiveGestureType = cleanInteractiveGestureType(interactiveGestureType)
    if interactiveGestureType.containsString("left") {
      return .Left
    } else if interactiveGestureType.containsString("right") {
      return .Right
    } else if interactiveGestureType.containsString("top") {
      return .Top
    } else if interactiveGestureType.containsString("bottom") {
      return .Bottom
    }
    return nil
  }

  static func fromStringWithDirection(interactiveGestureType: String) -> InteractiveGestureType? {
    guard let direction = interactiveGestureDirection(forInteractiveGestureType: interactiveGestureType) else {
      return nil
    }
    
    if interactiveGestureType.hasPrefix("Pan") {
      return .Pan(direction: direction)
    }
    return nil
  }

}