//
//  Created by Jake Lin on 5/12/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

final class InteractionTableViewController: UITableViewController {

}

// MARK: - UITableViewDataSource / UITableViewDelegate

extension InteractionTableViewController {

  // MARK: - reset the group heander font color and size
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    if let header = view as? UITableViewHeaderFooterView {
      header.textLabel?.textColor = .white
      header.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
    }
  }
}
