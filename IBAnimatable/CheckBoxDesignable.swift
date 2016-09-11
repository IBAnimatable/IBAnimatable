//
//  Created by Jake Lin on 12/20/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol CheckBoxDesignable {
  var checked: Bool { get set }
  var checkedImage: UIImage? { get set }
  var uncheckedImage: UIImage? { get set }
}

public extension CheckBoxDesignable where Self: UIButton {
  public func configureCheckBoxChecked() {
    isSelected = checked
  }
  
  public func configureCheckBoxCheckedImage() {
    guard let unwrappedCheckedImage = checkedImage else {
      return
    }
    
    setBackgroundImage(unwrappedCheckedImage, for: .selected)
    setBackgroundImage(unwrappedCheckedImage, for: [.selected, .highlighted])
  }
  
  public func configureCheckBoxUncheckedImage() {
    guard let unwrappedUncheckedImage = uncheckedImage else {
      return
    }
    
    setBackgroundImage(unwrappedUncheckedImage, for: UIControlState())
  }
}
