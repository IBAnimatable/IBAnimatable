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
  case fade = "fade"      // kCATransitionFade
  case moveIn = "moveIn"  // kCATransitionMoveIn
  case push = "push"      // kCATransitionPush
  case reveal = "reveal"  // kCATransitionReveal
  case flip = "flip"
  case cube = "cube"
  case pageCurl = "pageCurl"
  case pageUnCurl = "pageUnCurl"
  case rippleEffect = "rippleEffect"
  case suckEffect = "suckEffect"
  case cameraIris = "cameraIris"
  case cameraIrisHollowOpen = "cameraIrisHollowOpen"
  case cameraIrisHollowClose = "cameraIrisHollowClose"
  case rotate = "rotate"
}
