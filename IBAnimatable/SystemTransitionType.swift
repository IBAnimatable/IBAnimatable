//
// Created by Jake Lin on 2/24/16.
// Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import Foundation

/**
  System Transition Type: map to iOS built-in CATransition Type
  refer to http://iphonedevwiki.net/index.php/CATransition
*/
public enum SystemTransitionType: String {
  case Fade = "fade"      // kCATransitionFade
  case MoveIn = "moveIn"  // kCATransitionMoveIn
  case Push = "push"      // kCATransitionPush
  case Reveal = "reveal"  // kCATransitionReveal
  case Flip = "flip"
  case Cube = "cube"
  case PageCurl = "pageCurl"
  case PageUnCurl = "pageUnCurl"
  case RippleEffect = "rippleEffect"
  case SuckEffect = "suckEffect"
  case CameraIris = "cameraIris"
  case CameraIrisHollowOpen = "cameraIrisHollowOpen"
  case CameraIrisHollowClose = "cameraIrisHollowClose"
  case Rotate = "rotate"
}
