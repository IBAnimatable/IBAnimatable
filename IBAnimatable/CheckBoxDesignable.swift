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
    selected = checked
  }
  
  public func configCheckBoxCheckedImage() {
    guard let unwrappedCheckedImage = checkedImage else {
      return
    }
    
    setBackgroundImage(unwrappedCheckedImage, forState: .Selected)
    setBackgroundImage(unwrappedCheckedImage, forState: [.Selected, .Highlighted])
  }
  
  public func configCheckBoxUncheckedImage() {
    guard let unwrappedUncheckedImage = uncheckedImage else {
      return
    }
    
    setBackgroundImage(unwrappedUncheckedImage, forState: .Normal)
  }
}
