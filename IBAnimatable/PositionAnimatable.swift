//
//  Created by Jake Lin on 11/20/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol PositionAnimatable : Animatable {
  var x: CGFloat { get set }
  var y: CGFloat { get set }
}
