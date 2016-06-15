//
//  Created by Jake Lin on 12/20/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol CheckBoxDesignable {
  var checked: Bool { get set }
  var checkedImage: UIImage? { get set }
  var uncheckedImage: UIImage? { get set }
}

public extension CheckBoxDesignable where Self: UIButton {
  public func configCheckBoxChecked() {
    isSelected = checked
  }
  
  public func configCheckBoxCheckedImage() {
    guard let unwrappedCheckedImage = checkedImage else {
      return
    }
    
    setBackgroundImage(unwrappedCheckedImage, for: .selected)
    setBackgroundImage(unwrappedCheckedImage, for: [.selected, .highlighted])
  }
  
  public func configCheckBoxUncheckedImage() {
    guard let unwrappedUncheckedImage = uncheckedImage else {
      return
    }
    
    setBackgroundImage(unwrappedUncheckedImage, for: UIControlState())
  }
}
