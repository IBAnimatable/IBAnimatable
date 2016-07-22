//
//  Created by Jake Lin on 4/6/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
/**
 Interactive Animator Factory
 */
struct InteractiveAnimatorFactory {
  static func generateInteractiveAnimator(interactiveGestureType: InteractiveGestureType, transitionType: TransitionType) -> InteractiveAnimator? {
    switch interactiveGestureType {
    case .Pan:
      return PanInteractiveAnimator(interactiveGestureType: interactiveGestureType, transitionType: transitionType)
    case .ScreenEdgePan:
      return ScreenEdgePanInteractiveAnimator(interactiveGestureType: interactiveGestureType, transitionType: transitionType)
    case .Pinch:
      return PinchInteractiveAnimator(interactiveGestureType: interactiveGestureType, transitionType: transitionType)
    default:
      return nil
    }
  }
}
