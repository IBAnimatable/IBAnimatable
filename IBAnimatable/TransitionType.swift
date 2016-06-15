//
//  Created by Jake Lin on 3/16/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

enum TransitionType {
  case navigationTransition(UINavigationControllerOperation)
  case presentationTransition(PresentationOperation)
  case tabTransition(TabOperation)
}

enum PresentationOperation {
  case presentation, dismissal
}

enum TabOperation {
  case toLeft, toRight
}
