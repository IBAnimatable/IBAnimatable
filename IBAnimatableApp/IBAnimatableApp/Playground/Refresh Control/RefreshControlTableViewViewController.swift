//
//  Created by Eric Marchand on 31/03/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class RefreshControlTableViewViewController: AnimatableViewController {

  @IBOutlet fileprivate weak var tableView: AnimatableTableView!
  fileprivate let rows = ["Did you try to pull?",
                          "Nice control, isn't it?",
                          "Fully customisable in interface builder",
                          "Amazing!"]

  override public func viewDidLoad() {
    super.viewDidLoad()

    // Install action on refresh
    let refreshControl: UIRefreshControl?
    if #available(iOS 10.0, *) {
      refreshControl = tableView.refreshControl
    } else {
      refreshControl = UIRefreshControl()
      tableView.addSubview(refreshControl!)
      tableView.configureRefreshController()
    }
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
    if let color = tableView.refreshControlTintColor {
      attributes[NSAttributedString.Key.foregroundColor] = color
    }
    refreshControl.attributedTitle = NSAttributedString(string: "\(Int(time))", attributes: attributes )

    DispatchQueue.main.after(1) {
      self.updateMessage(refreshControl: refreshControl, time: time - 1)
    }
  }

}

// MARK: DispatchQueue utility extension

extension RefreshControlTableViewViewController: UITableViewDataSource {

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rows.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "refreshControllCell", for: indexPath) as UITableViewCell
    cell.textLabel?.text = rows[indexPath.row]
    return cell
  }

}

// MARK: DispatchQueue utility extension

fileprivate extension DispatchQueue {

  static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }

  func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
    asyncAfter(deadline: .now() + delay, execute: closure)
  }

}
