//
//  Created by Jake Lin on 2/20/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class AnimatableNavigationController: UINavigationController {
  class Navigator: NSObject, UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      if operation == .Push {
        return CubeFromLeftAnimator()
      } else if operation == .Pop {
        return CubeFromRightAnimator()
      }
      return nil
    }
  }
  
  let navigator = Navigator()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    delegate = navigator
  }
}
