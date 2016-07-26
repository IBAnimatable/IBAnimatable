//
//  Created by Jake Lin on 4/5/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ScreenEdgePanInteractiveAnimator: InteractiveAnimator {
  
  override func createGestureRecognizer() -> UIGestureRecognizer {
    let gestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
    switch interactiveGestureType {
    case let .ScreenEdgePan(direction):
      switch direction {
      case .Left:
        gestureRecognizer.edges = .Left
      case .Right:
        gestureRecognizer.edges = .Right
      case .Horizontal:
        gestureRecognizer.edges = [.Left, .Right]
      case .Top:
        gestureRecognizer.edges = .Top
      case .Bottom:
        gestureRecognizer.edges = .Bottom
      case .Vertical:
        gestureRecognizer.edges = [.Top, .Bottom]
      default:
        break
      }
    default:
      break
    }
    return gestureRecognizer
  }
  
  override func calculateProgress(gestureRecognizer: UIGestureRecognizer) -> (progress: CGFloat, shouldFinishInteractiveTransition: Bool) {
    guard let  gestureRecognizer = gestureRecognizer as? UIScreenEdgePanGestureRecognizer,
      superview = gestureRecognizer.view?.superview else {
        return (0, false)
    }
    let translation = gestureRecognizer.translationInView(superview)
    let velocity = gestureRecognizer.velocityInView(superview)
    
    var progress: CGFloat
    let distance: CGFloat
    let speed: CGFloat
    switch interactiveGestureType {
    case let .ScreenEdgePan(direction):
      switch direction {
      case .Horizontal:
        distance = superview.frame.width
        progress = abs(translation.x / distance)
        speed = abs(velocity.x)
      case .Left:
        distance = superview.frame.width
        progress = translation.x / distance
        speed = velocity.x
      case .Right:
        distance = superview.frame.width
        progress = -(translation.x / distance)
        speed = -velocity.x
      case .Vertical:
        distance = superview.frame.height
        progress = abs(translation.y / distance)
        speed = abs(velocity.y)
      case .Top:
        distance = superview.frame.height
        progress = translation.y / distance
        speed = velocity.y
      case .Bottom:
        distance = superview.frame.height
        progress = -translation.y / distance
        speed = -velocity.y
      default:
        return (0, false)
      }
    default:
      return (0, false)
    }
    
    progress = min(max(progress, 0), 0.99)
  
    // Finish the transition when pass the threathold
    let shouldFinishInteractiveTransition =  progress > 0.5 || speed > 1000
    
    return (progress, shouldFinishInteractiveTransition)
  }
}
