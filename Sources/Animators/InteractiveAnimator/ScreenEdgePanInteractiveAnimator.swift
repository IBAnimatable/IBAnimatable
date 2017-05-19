//
//  Created by Jake Lin on 4/5/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ScreenEdgePanInteractiveAnimator: InteractiveAnimator {

  override func makeGestureRecognizer() -> UIGestureRecognizer {
    let gestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(for:)))
    switch interactiveGestureType {
    case let .screenEdgePan(direction):
      switch direction {
      case .left:
        gestureRecognizer.edges = .left
      case .right:
        gestureRecognizer.edges = .right
      case .horizontal:
        gestureRecognizer.edges = [.left, .right]
      case .top:
        gestureRecognizer.edges = .top
      case .bottom:
        gestureRecognizer.edges = .bottom
      case .vertical:
        gestureRecognizer.edges = [.top, .bottom]
      default:
        break
      }
    default:
      break
    }
    return gestureRecognizer
  }

  override func calculateProgress(for gestureRecognizer: UIGestureRecognizer) -> (progress: CGFloat, shouldFinishInteractiveTransition: Bool) {
    guard let  gestureRecognizer = gestureRecognizer as? UIScreenEdgePanGestureRecognizer,
      let superview = gestureRecognizer.view?.superview else {
        return (0, false)
    }
    let translation = gestureRecognizer.translation(in: superview)
    let velocity = gestureRecognizer.velocity(in: superview)

    var progress: CGFloat
    let distance: CGFloat
    let speed: CGFloat
    switch interactiveGestureType {
    case let .screenEdgePan(direction):
      switch direction {
      case .horizontal:
        distance = superview.frame.width
        progress = abs(translation.x / distance)
        speed = abs(velocity.x)
      case .left:
        distance = superview.frame.width
        progress = translation.x / distance
        speed = velocity.x
      case .right:
        distance = superview.frame.width
        progress = -(translation.x / distance)
        speed = -velocity.x
      case .vertical:
        distance = superview.frame.height
        progress = abs(translation.y / distance)
        speed = abs(velocity.y)
      case .top:
        distance = superview.frame.height
        progress = translation.y / distance
        speed = velocity.y
      case .bottom:
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
    let shouldFinishInteractiveTransition = progress > 0.5 || speed > 1000
    return (progress, shouldFinishInteractiveTransition)
  }
}
