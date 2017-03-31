//
//  Created by phimage on 26/03/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit

public protocol RefreshControlDesignable {

  /**
   Component need to display a refresh control
   */
  var hasRefreshControl: Bool { get set }
  /**
   The tint color of the refresh control
   */
  var refreshControlTintColor: UIColor? { get set }
  /**
   The background color of the refresh control
   */
  var refreshControlBackgroundColor: UIColor? { get set }

}

public extension RefreshControlDesignable where Self: UITableViewController {

  func configureRefreshController() {
    if isViewLoaded {
      if hasRefreshControl {
        if refreshControl == nil {
          refreshControl = UIRefreshControl()
        }
        refreshControl?.tintColor = refreshControlTintColor
        refreshControl?.backgroundColor = refreshControlBackgroundColor
      } else {
        refreshControl = nil
      }
    }
  }

}
