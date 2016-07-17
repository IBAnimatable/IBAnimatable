//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit
import IBAnimatable

class PresentationsTableViewController: UITableViewController {

  private var presentationsAnimationsHeaders = [String]()
  private var presentationsAnimations = [[String]]()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    generateTransitionTypeData()
  }

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)

    guard let toNavigationController = segue.destinationViewController as? AnimatableNavigationController, indexPath = tableView.indexPathForSelectedRow else {
      return
    }

    let presentationAnimationType = String(presentationsAnimations[indexPath.section][indexPath.row])
    toNavigationController.transitionAnimationType = presentationAnimationType
    toNavigationController.navigationBar.topItem?.title = presentationAnimationType
    if let toViewController = toNavigationController.topViewController as? PresentationsViewController {
      toViewController.presentationAnimationType = presentationAnimationType
    }
  }

}

// MARK: - Factory

private extension PresentationsTableViewController {

  func generateTransitionTypeData() {
    presentationsAnimationsHeaders.append("CrossDissolve")
    presentationsAnimations.append(["CrossDissolve"])
    presentationsAnimationsHeaders.append("Flip")
    presentationsAnimations.append(["Flip"])
    presentationsAnimationsHeaders.append("Invert")
    presentationsAnimations.append(["Invert"])
    presentationsAnimationsHeaders.append("Cover")
    presentationsAnimations.append(presentationTypeWithDirections(forName: "Cover"))
  }

  func presentationTypeWithDirections(forName prefixName: String) -> [String] {
    return [prefixName + "(Left)", prefixName + "(Right)", prefixName + "(Top)", prefixName + "(Bottom)"]
  }
}

// MARK: - UITableViewDataSource / UITableViewDelegate

extension PresentationsTableViewController {

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return presentationsAnimations.count
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presentationsAnimations[section].count
  }

  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return presentationsAnimationsHeaders[section]
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("transitionCell", forIndexPath: indexPath) as UITableViewCell
    cell.textLabel?.text = presentationsAnimations[indexPath.section][indexPath.row]
    return cell
  }

  // MARK: - reset the group heander font color and size
  override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    if let header = view as? UITableViewHeaderFooterView {
      header.textLabel?.textColor = UIColor.whiteColor()
      header.textLabel?.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
    }
  }

}
