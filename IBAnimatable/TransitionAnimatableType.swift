//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
 Predefined Transition Animation Type
 */
public enum TransitionAnimationType: String {
  case Fade             // ToView fades in and FromeView fades out
  case FadeIn           // ToView fades in
  case FadeOut          // FromView Fades out
  case SystemCubeFromLeft
  case SystemCubeFromRight
  case SystemCubeFromTop
  case SystemCubeFromBottom
  case SystemFlipFromLeft
  case SystemFlipFromRight
  case SystemFlipFromTop
  case SystemFlipFromBottom
}
