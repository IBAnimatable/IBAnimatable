//
//  Created by Jake Lin on 12/16/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

public protocol BarButtonItemDesignable: AnyObject {
  var roundedImage: UIImage? { get set }
}

public extension BarButtonItemDesignable where Self: UIBarButtonItem {
  func configureBarButtonItemImage() {
    guard let roundedImage = roundedImage else {
      return
    }

    let originalImage: UIImage? = roundedImage.withRenderingMode(.alwaysOriginal)
    if let originalImage = originalImage {
      image = originalImage
    }
  }
}
