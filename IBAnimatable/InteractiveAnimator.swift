//
//  Created by Jake Lin on 4/5/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

// Super abstract class for all interactive animator subclasses
public class InteractiveAnimator: UIPercentDrivenInteractiveTransition {
  internal(set) public var interacting = false
  
  // transitionType: Used to deteminate pop or dismiss
  let transitionType: TransitionType
  // interactiveGestureType: Used to deteminate gesture type (direction)
  let interactiveGestureType: InteractiveGestureType
  // viewController: the viewController will connect to the gestureRecognizer
  var viewController: UIViewController?
  // gestureRecognizer: the gesture recognizer to handle gesture
  var gestureRecognizer: UIGestureRecognizer?
  
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
    let gestureRecognizerType = createGestureRecognizer()
    gestureRecognizer = gestureRecognizerType
    if let gestureRecognizer = gestureRecognizer {
      self.viewController?.view.addGestureRecognizer(gestureRecognizer)
    }
  }
  
  func handleGesture(gestureRecognizer: UIGestureRecognizer) {
    let (progress, shouldFinishInteractiveTransition) = calculateProgress(gestureRecognizer)
    
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
      if shouldFinishInteractiveTransition {
        finishInteractiveTransition()
      } else {
        cancelInteractiveTransition()
      }
    default:
      // Something happened. cancel the transition.
      interacting = false
      cancelInteractiveTransition()
      break
    }
  }
  
  // Because Swift doesn't support pure virtual method, need to throw error
  func createGestureRecognizer() -> UIGestureRecognizer {
    preconditionFailure("This method must be overridden")
  }
  
  func calculateProgress(gestureRecognizer: UIGestureRecognizer) -> (progress: CGFloat, shouldFinishInteractiveTransition: Bool) {
    preconditionFailure("This method must be overridden")
  }

}
