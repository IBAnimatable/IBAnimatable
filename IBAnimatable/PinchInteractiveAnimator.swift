//
//  Created by Jake Lin on 4/26/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class PinchInteractiveAnimator: InteractiveAnimator {
  private var startScale: CGFloat = 0
  
  override func createGestureRecognizer() -> UIGestureRecognizer {
    let gestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
    return gestureRecognizer
  }
  
  override func shouldBeginProgress(gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard let gestureRecognizer = gestureRecognizer as? UIPinchGestureRecognizer else {
      return false
    }
    
    switch interactiveGestureType {
    case let .Pinch(direction):
      switch direction {
      case .Close:
        return gestureRecognizer.velocity < 0
      case .Open:
        return gestureRecognizer.velocity > 0
      default:
        return true
      }
    default:
      return false
    }
  }
  
  override func calculateProgress(gestureRecognizer: UIGestureRecognizer) -> (progress: CGFloat, shouldFinishInteractiveTransition: Bool) {
    guard let  gestureRecognizer = gestureRecognizer as? UIPinchGestureRecognizer,
      _ = gestureRecognizer.view?.superview else {
        return (0, false)
    }
    
    if gestureRecognizer.state == .Began {
      startScale = gestureRecognizer.scale
    }
    
    var progress: CGFloat
    let _: CGFloat
    switch interactiveGestureType {
    case let .Pinch(direction):
      switch direction {
      case .Close:
        progress = 1.0 - gestureRecognizer.scale / startScale
      case .Open:
        let scaleFator: CGFloat = 1.2 // To make the pinch open gesture more natural 😓
        progress = gestureRecognizer.scale / scaleFator - 1.0
      default:
        // For both `.Close` and `.Open`
        progress = abs(1.0 - gestureRecognizer.scale / startScale)
    }
    default:
      return (0, false)
    }
    
    progress = min(max(progress, 0), 0.99)
    
    // Finish the transition when pass the threathold
    let shouldFinishInteractiveTransition =  progress > 0.5
    
    return (progress, shouldFinishInteractiveTransition)
  }
}
