//
//  Created by Jake Lin on 5/13/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class TransitionPushedViewController: UIViewController {

  private var predefinedGradients = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureRandomBackgroundColor()
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
}