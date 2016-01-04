//
//  Created by Jake Lin on 12/8/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol SideImageDesignable {
  /**
   * The left image
   */
  var leftImage: UIImage? { get set }
  
  /**
   * Left padding of the left image, default value is CGFloat.NaN
   */
  var leftImageLeftPadding: CGFloat { get set }
  
  /**
   * Right padding of the left image, default value is CGFloat.NaN
   */
  var leftImageRightPadding: CGFloat { get set }
  
  /**
   * Top padding of the left image, default value is CGFloat.NaN
   */
  var leftImageTopPadding: CGFloat { get set }
}

public extension SideImageDesignable where Self: UITextField {
  public func configLeftImage() {
    guard let wrappedLeftImage = leftImage else {
      return
    }
    
    let imageView = UIImageView(image: wrappedLeftImage)
    
    // If not set, use 0 as default value
    var leftImageLeftPaddingValue: CGFloat = 0.0
    if !leftImageLeftPadding.isNaN {
      leftImageLeftPaddingValue = leftImageLeftPadding
    }
    
    // If not set, use 0 as default value
    var leftImageRightPaddingValue: CGFloat = 0.0
    if !leftImageRightPadding.isNaN {
      leftImageRightPaddingValue = leftImageRightPadding
    }
    
    // If does not specify `leftImageTopPadding`, then center it in the middle
    if leftImageTopPadding.isNaN {
      imageView.frame.origin = CGPointMake(leftImageLeftPaddingValue, (bounds.height - imageView.bounds.height)/2)
    }
    else {
      imageView.frame.origin = CGPointMake(leftImageLeftPaddingValue, leftImageTopPadding)
    }
    
    let padding = leftImageLeftPaddingValue + imageView.bounds.size.width + leftImageRightPaddingValue
    let sideView = UIView(frame: CGRectMake(0, 0, padding, bounds.height))
    sideView.addSubview(imageView)
    
    leftViewMode = .Always
    leftView = sideView
  }
}
