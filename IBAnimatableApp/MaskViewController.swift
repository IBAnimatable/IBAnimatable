//
//  Created by Jake Lin on 6/29/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

class MaskViewController: UIViewController {
  
  var maskType: String?
  
  @IBOutlet var maskedView: AnimatableView!
  @IBOutlet var maskedImageView: AnimatableImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let maskType = MaskType(string: self.maskType)
    maskedView.maskType = maskType
    maskedImageView.maskType = maskType
  }
  
}
