//
//  Created by Jake Lin on 12/16/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol BarButtonItemDesignable {
  var roundedImage: String { get set }
}

public extension BarButtonItemDesignable where Self: UIBarButtonItem {
  public func confingBarButtonItemImage() {
    let originalImage: UIImage? = UIImage(named: roundedImage)?.imageWithRenderingMode(.AlwaysOriginal)
    if let unwrappedImage = originalImage {
      image = unwrappedImage
    }
  }
}
