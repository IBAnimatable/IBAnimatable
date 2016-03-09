//
//  Created by Jake Lin on 3/3/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PanInteractiveAnimator: UIPercentDrivenInteractiveTransition {
  private(set) public var interacting = false
  
  private let interactiveGestureType: InteractiveGestureType
  private var viewController: UIViewController?
  private var gestureRecognizer: UIPanGestureRecognizer?
  
  init(interactiveGestureType: InteractiveGestureType) {
    self.interactiveGestureType = interactiveGestureType
    super.init()
  }
  
  deinit {
    gestureRecognizer?.removeTarget(self, action: Selector("handleGesture:"))
  }
  
  func connectGestureRecognizer(viewController: UIViewController) {
    self.viewController = viewController
    gestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handleGesture:"))
    if let gestureRecognizer = gestureRecognizer {
      self.viewController?.view.addGestureRecognizer(gestureRecognizer)
    }
  }
  
  func handleGesture(gestureRecognizer: UIPanGestureRecognizer) {
    guard let view = gestureRecognizer.view, superview = view.superview else {
      return
    }
    let translation = gestureRecognizer.translationInView(superview)
    let velocity = gestureRecognizer.velocityInView(superview)
    
    var progress: CGFloat
    let distance: CGFloat
    if interactiveGestureType == .PanHorizontally {
      distance = superview.frame.width
      progress = abs(translation.x / distance)
    } else if interactiveGestureType == .PanFromLeft {
      distance = superview.frame.width
      progress = translation.x / distance
    } else if interactiveGestureType == .PanFromRight {
      distance = superview.frame.width
      progress = -(translation.x / distance)
    } else if (velocity.y > 0 && interactiveGestureType == .PanFromTop) ||
      (velocity.y < 0 && interactiveGestureType == .PanFromBottom) ||
      interactiveGestureType == .PanVertically {
        distance = superview.frame.height
        progress = abs(translation.y / distance)
    } else {
      return
    }
    progress = min(max(progress, 0), 0.99)

    switch gestureRecognizer.state {
    case .Began:
      interacting = true
      // TODO: only for pop now
      viewController?.navigationController?.popViewControllerAnimated(true)
    case .Changed:
      updateInteractiveTransition(progress)
    case .Cancelled, .Ended:
      interacting = false
      if progress < 0.5 || gestureRecognizer.state == .Cancelled {
        cancelInteractiveTransition()
      } else {
        finishInteractiveTransition()
      }
    default:
      // Something happened. cancel the transition.
      cancelInteractiveTransition()
      break
    }
  }
}
