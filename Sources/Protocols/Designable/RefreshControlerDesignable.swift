//
//  Created by phimage on 26/03/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit

public protocol RefreshControlDesignable: class {

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
    guard isViewLoaded else {
      return
    }

    configureRefreshController(hasRefreshControl: hasRefreshControl, refreshControl: &refreshControl)
  }

}

public extension RefreshControlDesignable where Self: UITableView {

  func configureRefreshController() {
    if #available(iOS 10.0, *) {
      configureRefreshController(hasRefreshControl: hasRefreshControl, refreshControl: &refreshControl)
    } else {
      var refreshControl = subviews.first { $0 is UIRefreshControl } as? UIRefreshControl
      configureRefreshController(hasRefreshControl: hasRefreshControl, refreshControl: &refreshControl)
    }
  }

}

fileprivate extension RefreshControlDesignable {

  func configureRefreshController(hasRefreshControl: Bool, refreshControl: inout UIRefreshControl?) {
    guard hasRefreshControl else {
      refreshControl = nil
      return
    }

    if refreshControl == nil {
      refreshControl = UIRefreshControl()
    }
    refreshControl?.tintColor = refreshControlTintColor
    refreshControl?.backgroundColor = refreshControlBackgroundColor
  }
}
