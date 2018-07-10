//
//  Created by Eric Marchand on 31/03/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class RefreshControlTableViewController: AnimatableTableViewController {

  override public func viewDidLoad() {
    super.viewDidLoad()

    // Install action on refresh
    refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
  }

  @objc
  public func refresh(_ refreshControl: UIRefreshControl) {
    // could update attributedTitle of refreshControl here
    // Simulate an asynchrone refresh, could be a network request...
    let time: TimeInterval = 5
    updateMessage(refreshControl: refreshControl, time: time)

    DispatchQueue.background.after(time) {
      // could update attributedTitle at each step
      // end refreshing, maybe reload table data if you do not implement table delegate to update each insert, update and delete events
      DispatchQueue.main.async {
        refreshControl.endRefreshing()
      }
    }
  }

  // Function to update message recursively
  func updateMessage(refreshControl: UIRefreshControl, time: TimeInterval) {
    guard time >= 0 else {
      return
    }

    var attributes = [NSAttributedString.Key: Any]()
    if let color = refreshControlTintColor {
      attributes[NSAttributedString.Key.foregroundColor] = color
    }
    refreshControl.attributedTitle = NSAttributedString(string: "\(Int(time))", attributes: attributes )

    DispatchQueue.main.after(1) {
      self.updateMessage(refreshControl: refreshControl, time: time - 1)
    }
  }

}

// MARK: DispatchQueue utility extension

fileprivate extension DispatchQueue {

  static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }

  func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
    asyncAfter(deadline: .now() + delay, execute: closure)
  }

}
