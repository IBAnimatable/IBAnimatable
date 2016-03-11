//
//  Created by Jake Lin on 3/3/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

/**
 The interactive gesture type
 */
public enum InteractiveGestureType: String {
  case Default          // Will use the default interactive gesture type from `AnimatedTransitioning`
  case PanHorizontally
  case PanVertically
  case PanFromLeft
  case PanFromRight
  case PanFromTop
  case PanFromBottom
}
