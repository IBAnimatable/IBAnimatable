//
//  Created by Jake Lin on 3/16/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

enum TransitionType {
  case NavigationTransition(UINavigationControllerOperation)
  case PresentationTransition(PresentationOperation)
  case TabTransition(TabOperation)
}

enum PresentationOperation {
  case Presentation, Dismissal
}

enum TabOperation {
  case ToLeft, ToRight
}
