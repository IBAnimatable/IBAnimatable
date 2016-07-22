//
//  Created by Jake Lin on 4/5/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
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
  weak var viewController: UIViewController?
  // gestureRecognizer: the gesture recognizer to handle gesture
  var gestureRecognizer: UIGestureRecognizer?
  
  init(interactiveGestureType: InteractiveGestureType, transitionType: TransitionType) {
    self.interactiveGestureType = interactiveGestureType
    self.transitionType = transitionType
    super.init()
  }
  
  deinit {
    if let gestureRecognizer = gestureRecognizer, view = viewController?.view {
      gestureRecognizer.removeTarget(self, action: #selector(handleGesture(_:)))
      view.removeGestureRecognizer(gestureRecognizer)
    }
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
      guard shouldBeginProgress(gestureRecognizer) else {
        return
      }
      
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
      // Something happened then cancel the transition.
      interacting = false
      cancelInteractiveTransition()
      break
    }
  }
  
  // Because Swift doesn't support pure virtual method, need to throw error
  func createGestureRecognizer() -> UIGestureRecognizer {
    preconditionFailure("This method must be overridden")
  }
  
  func shouldBeginProgress(gestureRecognizer: UIGestureRecognizer) -> Bool {
    // return true by default
    return true
  }
  
  func calculateProgress(gestureRecognizer: UIGestureRecognizer) -> (progress: CGFloat, shouldFinishInteractiveTransition: Bool) {
    preconditionFailure("This method must be overridden")
  }

}
