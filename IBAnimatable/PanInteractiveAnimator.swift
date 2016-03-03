//
//  Created by Jake Lin on 3/3/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PanInteractiveAnimator: UIPercentDrivenInteractiveTransition {
  private let viewController: UIViewController
  private let gestureFromDirection: GestureFromDirection
  
  private var gestureRecognizer: UIPanGestureRecognizer?
  
  init(viewController: UIViewController, gestureFromDirection: GestureFromDirection) {
    self.viewController = viewController
    self.gestureFromDirection = gestureFromDirection
    super.init()
    
    gestureRecognizer = UIPanGestureRecognizer(target: self, action: "handleGesture:")
  }
  
  func handleGesture(gestureRecognizer: UIPanGestureRecognizer) {
    guard let view = gestureRecognizer.view, superview = view.superview else {
      return
    }
    let translation = gestureRecognizer.translationInView(superview)
    
    // width or heigth depends on the gesture direction
    let distance: CGFloat
    switch gestureFromDirection {
    case .FromLeft:
      distance = superview.frame.width
    case .FromRight:
      distance = superview.frame.width
    case .FromTop:
      distance = superview.frame.height
    case .FromBottom:
      distance = superview.frame.height
    }
    
    var progress: CGFloat = abs(translation.x / distance)
    progress = min(max(progress, 0.01), 0.99)
    
    switch gestureRecognizer.state {
    case .Changed:
      updateInteractiveTransition(progress)
      
    case .Cancelled, .Ended:
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