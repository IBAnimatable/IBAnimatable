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
  
  func connectGestureRecognizer(_ viewController: UIViewController) {
    self.viewController = viewController
    let gestureRecognizerType = createGestureRecognizer()
    gestureRecognizer = gestureRecognizerType
    if let gestureRecognizer = gestureRecognizer {
      self.viewController?.view.addGestureRecognizer(gestureRecognizer)
    }
  }
  
  func handleGesture(_ gestureRecognizer: UIGestureRecognizer) {
    let (progress, shouldFinishInteractiveTransition) = calculateProgress(gestureRecognizer)
    
    switch gestureRecognizer.state {
    case .began:
      guard shouldBeginProgress(gestureRecognizer) else {
        return
      }
      
      interacting = true
      switch transitionType {
      case .navigationTransition(.pop):
        viewController?.navigationController?.popViewController(animated: true)
      case .presentationTransition(.dismissal):
        viewController?.dismiss(animated: true, completion: nil)
      default:
        break
      }
    case .changed:
      update(progress)
    case .cancelled, .ended:
      interacting = false
      if shouldFinishInteractiveTransition {
        finish()
      } else {
        cancel()
      }
    default:
      // Something happened then cancel the transition.
      interacting = false
      cancel()
      break
    }
  }
  
  // Because Swift doesn't support pure virtual method, need to throw error
  func createGestureRecognizer() -> UIGestureRecognizer {
    preconditionFailure("This method must be overridden")
  }
  
  func shouldBeginProgress(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    // return true by default
    return true
  }
  
  func calculateProgress(_ gestureRecognizer: UIGestureRecognizer) -> (progress: CGFloat, shouldFinishInteractiveTransition: Bool) {
    preconditionFailure("This method must be overridden")
  }

}
