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
    gestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handleGesture:"))
  }
  
  func connectGestureRecognizer(viewController: UIViewController) {
    self.viewController = viewController
    if let gestureRecognizer = gestureRecognizer {
      self.viewController?.view.addGestureRecognizer(gestureRecognizer)
    }
  }
  
  func handleGesture(gestureRecognizer: UIPanGestureRecognizer) {
    guard let view = gestureRecognizer.view, superview = view.superview else {
      return
    }
    let translation = gestureRecognizer.translationInView(superview)
    
    // width or heigth depends on the gesture direction
    let distance: CGFloat
    if interactiveGestureType == .PanHorizontally ||
      interactiveGestureType == .PanFromLeft ||
      interactiveGestureType == .PanFromRight {
      distance = superview.frame.width
    } else if interactiveGestureType == .PanVertically ||
      interactiveGestureType == .PanFromTop ||
      interactiveGestureType == .PanFromBottom {
        distance = superview.frame.height
    }
    else {
      return
    }
    
    var progress: CGFloat = abs(translation.x / distance)
    progress = min(max(progress, 0.01), 0.99)
    
    switch gestureRecognizer.state {
    case .Began:
      interacting = true
      // TODO: only for pop now
      viewController?.navigationController?.popViewControllerAnimated(true)
    case .Changed:
      updateInteractiveTransition(progress)
    case .Cancelled, .Ended:
      interacting = false
      if progress < 0.5 {
        cancelInteractiveTransition()
      } else {
        finishInteractiveTransition()
      }
    default:
      break
    }
  }
}
