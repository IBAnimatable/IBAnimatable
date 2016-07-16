//
//  Created by Jake Lin on 6/29/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

class UserInterfaceMaskTableViewController: UITableViewController {
  private let masks = ["None", "Circle", "Polygon", "Polygon(12)", "Star", "Star(6)", "Triangle", "Wave", "Wave(up,10,5)", "Wave(down,40,0)", "Parallelogram", "Parallelogram(150)"]
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let maskViewController = segue.destinationViewController as? MaskViewController, indexPath = tableView.indexPathForSelectedRow {
      maskViewController.maskType = masks[indexPath.row]
    }
  }
}

// MARK: - UITableViewDataSource / UITableViewDelegate
extension UserInterfaceMaskTableViewController {
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return masks.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("transitionCell", forIndexPath: indexPath) as UITableViewCell
    cell.textLabel?.text = masks[indexPath.row]
    return cell
  }
}
