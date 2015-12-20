//
//  Created by Jake Lin on 12/16/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol BarButtonItemDesignable {
  var roundedImage: UIImage? { get set }
}

public extension BarButtonItemDesignable where Self: UIBarButtonItem {
  public func confingBarButtonItemImage() {
    guard let unwrappedRoundedImage = roundedImage else {
      return
    }
    
    let originalImage: UIImage? = unwrappedRoundedImage.imageWithRenderingMode(.AlwaysOriginal)
    if let unwrappedImage = originalImage {
      image = unwrappedImage
    }
  }
}
