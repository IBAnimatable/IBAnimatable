//
//  Created by Jake Lin on 5/16/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

extension UIViewController {
  
  func generateRandomGradient() -> GradientType {
    var predefinedGradients = [GradientType]()
    iterateEnum(GradientType).forEach {
      predefinedGradients.append($0)
    }
    
    let randomIndex: Int = Int(arc4random_uniform(UInt32(predefinedGradients.count)))
    return predefinedGradients[randomIndex]
  }
  
  func retrieveGestureText(interactiveGestureType: InteractiveGestureType, transitionAnimationType: TransitionAnimationType, exit: String) -> String {
    switch interactiveGestureType {
    case .Default:
      // Default gesture
      let transitionAnimator = AnimatorFactory.generateAnimator(transitionAnimationType)
      if let interactiveGestureType = transitionAnimator.interactiveGestureType {
        return String("or use \(interactiveGestureType.toString()) gesture to \(exit)")
      }
      
      // The transition animator doesn't have default `interactiveGestureType`
      return ""
    default:
      // Specified gesture
      return String("or use \(interactiveGestureType.toString()) gesture to \(exit)")
    }
  }
  
}
