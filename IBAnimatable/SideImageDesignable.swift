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
    if (leftImage == "") {
      return
    }
    
    let image = UIImage(named: leftImage)
    let imageView = UIImageView(image: image)
    print(imageView.bounds.size.width)
    let padding = leftImagePaddingLeft + imageView.bounds.size.width + leftImagePaddingRight
    let sideView = UIView(frame: CGRectMake(0, 0, padding, 0))
    sideView.addSubview(imageView)
    
    leftViewMode = .Always
    leftView = sideView
  }
  
}

