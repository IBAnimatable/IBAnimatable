//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol MaskDesignable {
  var maskType: String? { get set }
}

public extension MaskDesignable where Self: UIView {
  public func configMask() {
    guard let unwrappedMaskType = maskType, rawMaskType = MaskType(rawValue: unwrappedMaskType) else {
      return
    }
    
    switch(rawMaskType) {
    case .Circle:
      maskCircle()
    }
  }
  
  // MARK: - Private
  private func maskCircle() {
    layer.cornerRadius = ceil(min(bounds.width, bounds.height))/2
  }
}
