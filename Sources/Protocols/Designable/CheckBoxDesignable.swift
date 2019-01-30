//
//  Created by Jake Lin on 12/20/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol CheckBoxDesignable: class {
  var checked: Bool { get set }
  var checkedImage: UIImage? { get set }
  var uncheckedImage: UIImage? { get set }
}

public extension CheckBoxDesignable where Self: UIButton {
  func configureCheckBoxChecked() {
    isSelected = checked
  }

  func configureCheckBoxCheckedImage() {
    guard let checkedImage = checkedImage else {
      return
    }

    setBackgroundImage(checkedImage, for: .selected)
    setBackgroundImage(checkedImage, for: [.selected, .highlighted])
  }

  func configureCheckBoxUncheckedImage() {
    guard let uncheckedImage = uncheckedImage else {
      return
    }

    setBackgroundImage(uncheckedImage, for: UIControl.State())
  }
}
