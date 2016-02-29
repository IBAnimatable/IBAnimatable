//
//  Created by Jake Lin on 2/29/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

class TransitionTableViewController: UITableViewController {

  private var transitionAnimations = [TransitionAnimationType.Fade, .FadeIn, .FadeOut, .SystemCubeFromLeft]

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // TODO: Loop through `TransitionAnimationType` enum to generate the table dynamically.
  }

  // MARK: - UITableViewDataSource
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier("transitionCell") else {
      return UITableViewCell()
    }
    cell.textLabel?.text = transitionAnimations[indexPath.row].rawValue
    return cell
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return transitionAnimations.count
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    guard let toViewController = segue.destinationViewController as? AnimatableNavigationController, path = tableView.indexPathForSelectedRow else {
      return
    }
  
    toViewController.transitionAnimationType = String(transitionAnimations[path.row])
  }
  
}
