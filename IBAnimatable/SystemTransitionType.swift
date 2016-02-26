//
// Created by Jake Lin on 2/24/16.
// Copyright (c) 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
  System Transition Type: map to iOS built-in CATransition Type
  refer to http://iphonedevwiki.net/index.php/CATransition
*/
public enum SystemTransitionType: String {
  case Fade = "fade"
  case MoveIn = "moveIn"
  case Push = "push"
  case Reveal = "reveal"
  case Flip = "flip"
  case AlignedFlip = "alignedFlip"
  case OglFlip = "oglFlip"
  case Cube = "cube"
  case AlignedCube = "alignedCube"
  case PageCurl = "pageCurl"
  case PageUnCurl = "pageUnCurl"
  case RippleEffect = "rippleEffect"
  case SuckEffect = "suckEffect"
  case CameraIris = "cameraIris"
  case CameraIrisHollowOpen = "cameraIrisHollowOpen"
  case CameraIrisHollowClose = "cameraIrisHollowClose"
  case Rotate = "rotate"
  case SpewEffect = "spewEffect"
  case GenieEffect = "genieEffect"
  case UnGenieEffect = "unGenieEffect"
  case Twist = "twist"
  case Swirl = "swirl"
  case CharminUltra = "charminUltra"
  case Reflection = "reflection"
  case ZoomyIn = "zoomyIn"
  case ZoomyOut = "zoomyOut"
  case MapCurl = "mapCurl"
  case MapUnCurl = "mapUnCurl"
  case OglApplicationSuspend = "oglApplicationSuspend"
  case CameraIrisHollow = "cameraIrisHollow"
}
