//
//  Created by Jake Lin on 3/3/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PanInteractiveAnimator: UIPercentDrivenInteractiveTransition {
  private(set) public var interacting = false
  
  // transitionType: Used to deteminate pop or dismiss
  private let transitionType: TransitionType
  // interactiveGestureType: Used to deteminate gesture type (direction)
  private let interactiveGestureType: InteractiveGestureType
  // viewController: the viewController will connect to the gestureRecognizer
  private var viewController: UIViewController?
  // gestureRecognizer: the gesture recognizer to handle gesture
  private var gestureRecognizer: UIPanGestureRecognizer?
  
  init(interactiveGestureType: InteractiveGestureType, transitionType: TransitionType) {
    self.interactiveGestureType = interactiveGestureType
    self.transitionType = transitionType
    super.init()
  }
  
  deinit {
    gestureRecognizer?.removeTarget(self, action: #selector(handleGesture(_:)))
  }
  
  func connectGestureRecognizer(viewController: UIViewController) {
    self.viewController = viewController
    gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
    if let gestureRecognizer = gestureRecognizer {
      self.viewController?.view.addGestureRecognizer(gestureRecognizer)
    }
  }
  
  func handleGesture(gestureRecognizer: UIPanGestureRecognizer) {
    guard let superview = gestureRecognizer.view?.superview else {
      return
    }
    let translation = gestureRecognizer.translationInView(superview)
    let velocity = gestureRecognizer.velocityInView(superview)
    
    var progress: CGFloat
    let distance: CGFloat
    let speed: CGFloat
    switch interactiveGestureType {
    case .PanHorizontally:
      distance = superview.frame.width
      progress = abs(translation.x / distance)
      speed = abs(velocity.x)
    case .PanFromLeft:
      distance = superview.frame.width
      progress = translation.x / distance
      speed = velocity.x
    case .PanFromRight:
      distance = superview.frame.width
      progress = -(translation.x / distance)
      speed = -velocity.x
    case .PanVertically:
      distance = superview.frame.height
      progress = abs(translation.y / distance)
      speed = abs(velocity.y)
    case .PanFromTop:
      distance = superview.frame.height
      progress = translation.y / distance
      speed = velocity.y
    case .PanFromBottom:
      distance = superview.frame.height
      progress = -translation.y / distance
      speed = -velocity.y
    default:
      return
    }
    
    progress = min(max(progress, 0), 0.99)
    switch gestureRecognizer.state {
    case .Began:
      interacting = true
      switch transitionType {
      case .NavigationTransition(.Pop):
        viewController?.navigationController?.popViewControllerAnimated(true)
      case .PresentationTransition(.Dismissal):
        viewController?.dismissViewControllerAnimated(true, completion: nil)
      default:
        break
      }
    case .Changed:
      updateInteractiveTransition(progress)
    case .Cancelled, .Ended:
      interacting = false
      // Finish the transition when pass the threathold
      if progress > 0.5 || speed > 1000 {
        finishInteractiveTransition()
      } else {
        cancelInteractiveTransition()
      }
    default:
      // Something happened. cancel the transition.
      cancelInteractiveTransition()
      break
    }
  }
}
