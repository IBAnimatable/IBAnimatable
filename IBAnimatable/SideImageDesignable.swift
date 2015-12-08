//
//  Created by Jake Lin on 12/8/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol SideImageDesignable {
  var leftImage: String { get set }
  var leftImagePaddingLeft: CGFloat { get set }
  var leftImagePaddingRight: CGFloat { get set }
}

public extension SideImageDesignable where Self: UITextField {
  public func configLeftImage() {
    let image = UIImage(named: leftImage)
    let sideView = UIView(frame: CGRectMake(0, 0, leftImagePaddingLeft + leftImagePaddingRight, 0))
    sideView.addSubview(UIImageView(image: image))
    
    leftViewMode = .Always
    leftView = sideView
  }
  
}

