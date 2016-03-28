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
  case SystemCube(direction: TransitionFromDirection)
  case SystemFlip(direction: TransitionFromDirection)
  case SystemPageCurl(direction: TransitionFromDirection)

  var stringValue: String {
    return String(self)
  }

  static func fromString(string: String) -> TransitionAnimationType? {
    if String(TransitionAnimationType.Fade) == string {
      return .Fade
    } else if String(TransitionAnimationType.SystemCube(direction: .Left)) == string {
      return .SystemCube(direction: .Left)
    }
    return nil
  }

}
