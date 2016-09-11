//
//  Created by Jake Lin on 4/6/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
/**
 Interactive Animator Factory
 */
struct InteractiveAnimatorFactory {
  static func makeInteractiveAnimator(interactiveGestureType: InteractiveGestureType, transitionType: TransitionType) -> InteractiveAnimator? {
    switch interactiveGestureType {
    case .pan:
      return PanInteractiveAnimator(interactiveGestureType: interactiveGestureType, transitionType: transitionType)
    case .screenEdgePan:
      return ScreenEdgePanInteractiveAnimator(interactiveGestureType: interactiveGestureType, transitionType: transitionType)
    case .pinch:
      return PinchInteractiveAnimator(interactiveGestureType: interactiveGestureType, transitionType: transitionType)
    default:
      return nil
    }
  }
}
