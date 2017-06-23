//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

final class PresentedViewController: AnimatableModalViewController {

  @IBOutlet private var presentViaSegueButton: AnimatableButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    if let animatableView = view as? AnimatableView {
      animatableView.predefinedGradient = makeRandomGradient()
    }
  }

}
