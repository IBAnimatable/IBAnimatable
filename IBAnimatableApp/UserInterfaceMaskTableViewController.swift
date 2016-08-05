//
//  Created by Jake Lin on 6/29/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

class UserInterfaceMaskTableViewController: UITableViewController {
  private let masks = ["None", "Circle", "Polygon", "Polygon(12)", "Star", "Star(6)", "Triangle", "Wave", "Wave(up,10,5)", "Wave(down,40,0)", "Parallelogram", "Parallelogram(150)"]
  
  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    if let maskViewController = segue.destination as? MaskViewController, let indexPath = tableView.indexPathForSelectedRow {
      maskViewController.maskType = masks[indexPath.row]
    }
  }
}

// MARK: - UITableViewDataSource / UITableViewDelegate
extension UserInterfaceMaskTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return masks.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "transitionCell", for: indexPath as IndexPath) as UITableViewCell
    cell.textLabel?.text = masks[indexPath.row]
    return cell
  }
}
