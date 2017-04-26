//
//  Created by Jake Lin on 12/5/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit
import Darwin

/**
  It is not able to preview the rotation in IB.
*/
public protocol RotationDesignable: class {
  var rotate: CGFloat { get set }
}

public extension RotationDesignable where Self: UIView {
  public func configureRotate() {
    if !rotate.isNaN && rotate > -360 && rotate < 360 {
      transform = CGAffineTransform(rotationAngle: .pi * rotate / 180)
    }
  }
}
