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
  case fade     // kCATransitionFade
  case moveIn   // kCATransitionMoveIn
  case push     // kCATransitionPush
  case reveal   // kCATransitionReveal
  case flip
  case cube
  case pageCurl
  case pageUnCurl
  case rippleEffect
  case suckEffect
  case cameraIris
  case cameraIrisHollowOpen
  case cameraIrisHollowClose
  case rotate
}
