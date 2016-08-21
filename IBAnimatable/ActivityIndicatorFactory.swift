//
//  Created by Tom Baranes on 21/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public struct ActivityIndicatorFactory {
  public static func generateActivityIndicator(activityIndicatorType: ActivityIndicatorType) -> ActivityIndicatorAnimating {
    switch activityIndicatorType {
    case .None:
      fatalError()
    case .BallBeat:
      return ActivityIndicatorAnimationBallBeat()
    }
  }
}
