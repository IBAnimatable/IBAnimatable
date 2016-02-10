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
  
  /**
   * The right image
   */
  var rightImage: UIImage? { get set }
  
  /**
   * Left padding of the right image, default value is CGFloat.NaN
   */
  var rightImageLeftPadding: CGFloat { get set }
  
  /**
   * Right padding of the right image, default value is CGFloat.NaN
   */
  var rightImageRightPadding: CGFloat { get set }
  
  /**
   * Top padding of the right image, default value is CGFloat.NaN
   */
  var rightImageTopPadding: CGFloat { get set }
}

public extension SideImageDesignable where Self: UITextField {

  public func configLeftImage() {
    guard let wrappedLeftImage = leftImage else {
      return
    }
    
    let sideView = generateSideViewWithImage(wrappedLeftImage, leftPadding: leftImageLeftPadding, rightPadding: leftImageRightPadding, topPadding: leftImageTopPadding)
    leftViewMode = .Always
    leftView = sideView
  }
  
  public func configRightImage() {
    guard let wrappedRightImage = rightImage else {
      return
    }
    
    let sideView = generateSideViewWithImage(wrappedRightImage, leftPadding: rightImageLeftPadding, rightPadding: rightImageRightPadding, topPadding: rightImageTopPadding)
    rightViewMode = .Always
    rightView = sideView
  }
  
  private func generateSideViewWithImage(image: UIImage, leftPadding: CGFloat, rightPadding: CGFloat, topPadding: CGFloat) -> UIView {
    let imageView = UIImageView(image: image)
    
    // If not set, use 0 as default value
    var leftPaddingValue: CGFloat = 0.0
    if !leftPadding.isNaN {
      leftPaddingValue = leftPadding
    }
    
    // If not set, use 0 as default value
    var rightPaddingValue: CGFloat = 0.0
    if !rightPadding.isNaN {
      rightPaddingValue = rightPadding
    }

    // If does not specify `topPadding`, then center it in the middle
    if topPadding.isNaN {
      imageView.frame.origin = CGPoint(x: leftPaddingValue, y: (bounds.height - imageView.bounds.height) / 2)
    } else {
      imageView.frame.origin = CGPoint(x: leftPaddingValue, y: topPadding)
    }
    
    let padding = rightPaddingValue + imageView.bounds.size.width + leftPaddingValue
    let sideView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: bounds.height))
    sideView.addSubview(imageView)
    return sideView
  }
}
