//
//  Created by Jake Lin on 6/29/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class MaskViewController: UIViewController {
  
  var maskType: String?
  
  @IBOutlet var maskedView: AnimatableView!
  @IBOutlet var maskedImageView: AnimatableImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let eMaskType = MaskType(string: maskType)
    maskedView.eMaskType = eMaskType
    maskedImageView.eMaskType = eMaskType
  }
  
}
