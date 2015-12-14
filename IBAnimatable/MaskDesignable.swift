//
//  Created by Jake Lin on 12/13/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol MaskDesignable {
  var maskType: String { get set }
}

public extension MaskDesignable where Self: UIView {
  public func configMask() {
    guard let maskType = MaskType(rawValue: maskType) else {
      return
    }
    
    switch(maskType) {
    case .Circle:
      maskCircle()
    }
  }
  
  // MARK: - Private
  private func maskCircle() {
    layer.cornerRadius = min(bounds.width, bounds.height)/2
  }
}