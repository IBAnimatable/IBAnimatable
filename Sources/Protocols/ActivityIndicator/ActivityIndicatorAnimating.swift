//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

/// Protocol for all activity indicator classes.
public protocol ActivityIndicatorAnimating: class {
  /**
   Define the animation for the activity indicator.

   - Parameter layer: The layer to execute the animation
   - Parameter size: The size of the activity indicator.
   - Parameter color: The color of the activity indicator.
   */
  func configureAnimation(in layer: CALayer, size: CGSize, color: UIColor)

}
