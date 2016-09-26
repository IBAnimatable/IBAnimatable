//
//  Created by jason akakpo on 13/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

class BorderViewController: UIViewController {

  @IBOutlet weak var viewToBorder: AnimatableView!
  @IBOutlet weak var topCheckBox: AnimatableCheckBox!
  @IBOutlet weak var botCheckBox: AnimatableCheckBox!
  @IBOutlet weak var leftCheckBox: AnimatableCheckBox!
  @IBOutlet weak var rightCheckBox: AnimatableCheckBox!
  @IBOutlet weak var topOutCheckBox: AnimatableCheckBox!
  @IBOutlet weak var botOutCheckBox: AnimatableCheckBox!
  @IBOutlet weak var leftOutCheckBoxOut: AnimatableCheckBox!
  @IBOutlet weak var rightOutCheckBox: AnimatableCheckBox!

  @IBAction func boxChecked(_ sender: AnimatableCheckBox) {
    let border: BorderSides
    switch sender {
    case topCheckBox:
      border = .top
    case botCheckBox:
      border = .bottom
    case leftCheckBox:
      border = .left
    case rightCheckBox:
      border = .right
    case topOutCheckBox:
        border = .topOut
    case botOutCheckBox:
        border = .bottomOut
    case leftOutCheckBoxOut:
        border = .leftOut
    case rightOutCheckBox:
        border = .rightOut
    default:
      return
    }

    if sender.checked {
      viewToBorder.borderSides.insert(border)
    } else {
      viewToBorder.borderSides.remove(border)
    }
    
  }
  

}
