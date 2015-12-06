//
//  Created by Jake Lin on 12/5/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol RotationDesignable {
  var rotate: CGFloat { get set }
}

public extension RotationDesignable where Self: UIView {
  public func configRotate() {
    if (rotate > 0 && rotate < 360) {
      self.transform = CGAffineTransformMakeRotation(rotate)
    }
  }
}
