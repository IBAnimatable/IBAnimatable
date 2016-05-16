//
//  Created by Jake Lin on 5/13/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class TransitionPushedViewController: UIViewController {

  @IBOutlet var gestureLabel: UILabel!
  
  private var predefinedGradients = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureRandomBackgroundColor()
    configureGestureLabel()
  }

}

private extension TransitionPushedViewController {
  
  func configureRandomBackgroundColor() {
    iterateEnum(GradientType).forEach {
      predefinedGradients.append(String($0))
    }
    
    if let animatableView = view as? AnimatableView {
      let randomIndex: Int = Int(arc4random_uniform(UInt32(predefinedGradients.count)))
      animatableView.predefinedGradient = predefinedGradients[randomIndex]
    }
  }
  
  func configureGestureLabel() {
    // Shows nothing by default
    gestureLabel.text = "to pop"
    
    guard let navigationController = self.navigationController as? AnimatableNavigationController else {
      return
    }
    
    // No gesture for this animator
    guard let interactiveGestureTypeString = navigationController.interactiveGestureType,
      interactiveGestureType = InteractiveGestureType.fromString(interactiveGestureTypeString),
      transitionAnimationTypeString = navigationController.transitionAnimationType,
      transitionAnimationType = TransitionAnimationType.fromString(transitionAnimationTypeString) else {
      return
    }
    
    switch interactiveGestureType {
    case .Default:
      // Default gesture
      let transitionAnimator = AnimatorFactory.generateAnimator(transitionAnimationType)
      if let interactiveGestureType = transitionAnimator.interactiveGestureType {
        gestureLabel.text = String("or use \(interactiveGestureType.toString()) gesture to pop")
      }
    default:
      // Specified gesture
      gestureLabel.text = String("or use \(interactiveGestureType.toString()) gesture to pop")
    }
  }
  
}