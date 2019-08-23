//
//  Created by phimage on 23/08/2019.
//  Copyright © 2019 IBAnimatable. All rights reserved.
//

import UIKit

extension UIStoryboardSegue {
  func present(animated flag: Bool = true) {
    if #available(iOS 13.0, *) {
      if destination.transitioningDelegate != nil {
        destination.modalPresentationStyle = .fullScreen // .automatic do not work well with our transitioningDelegate
      }
    }
    source.present(destination, animated: flag, completion: nil)
  }
}
