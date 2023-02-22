//
//  Created by phimage on 23/08/2019.
//  Copyright © 2019 IBAnimatable. All rights reserved.
//

import UIKit

extension UIStoryboardSegue {
  func present(animated flag: Bool = true) {
    #if swift(>=5.1)
    if #available(iOS 13.0, *) {
      if destination.transitioningDelegate != nil {
        let presentationStyle = destination.modalPresentationStyle
        if presentationStyle == .automatic || presentationStyle == .pageSheet {
          destination.modalPresentationStyle = .fullScreen // .automatic & .pageSheet do not work well with our transitioningDelegate
        }
      }
    }
    #endif
    source.present(destination, animated: flag, completion: nil)
  }
}
