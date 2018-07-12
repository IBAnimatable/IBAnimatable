//
//  Created by Jake Lin on 3/16/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

enum TransitionType {
  case navigationTransition(UINavigationController.Operation)
  case presentationTransition(PresentationOperation)
  case tabTransition(TabOperation)
}

enum PresentationOperation {
  case presentation, dismissal
}

enum TabOperation {
  case toLeft, toRight
}
