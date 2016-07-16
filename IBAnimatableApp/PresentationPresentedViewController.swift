//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class PresentationPresentedViewController: AnimatablePresentedViewController {

  @IBOutlet var presentViaSegueButton: AnimatableButton!

  // Intenal use for demo only
  var useDismissInteraction: Bool = true

  override func viewDidLoad() {
    super.viewDidLoad()

    if let animatableView = view as? AnimatableView {
      animatableView.predefinedGradient = String(generateRandomGradient())
    }
  }

}
