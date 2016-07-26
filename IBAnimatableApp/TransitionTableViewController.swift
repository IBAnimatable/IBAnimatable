//
//  Created by Jake Lin on 2/29/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

class TransitionTableViewController: UITableViewController {

  private var transitionAnimationsHeaders = [String]()
  private var transitionAnimations = [[String]]()

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
    
    let transitionAnimationType = String(transitionAnimations[indexPath.section][indexPath.row])
    
    // Set the transition animation type for `AnimatableNavigationController`, used for Push/Pop transitions
    toNavigationController.transitionAnimationType = transitionAnimationType
    toNavigationController.navigationBar.topItem?.title = transitionAnimationType
   
    // Set the transition animation type for `AnimatableViewController`, used for Present/Dismiss transitions
    if let toViewController = toNavigationController.topViewController as? TransitionViewController {
      toViewController.transitionAnimationType = transitionAnimationType
    }
  }

}

// MARK: - Factory

private extension TransitionTableViewController {
  
  func generateTransitionTypeData() {
    transitionAnimationsHeaders.append("Fade")
    transitionAnimations.append(["Fade", "Fade(In)", "Fade(Out)"])
    transitionAnimationsHeaders.append("SystemCube")
    transitionAnimations.append(transitionTypeWithDirections(forName: "SystemCube"))
    transitionAnimationsHeaders.append("SystemFlip")
    transitionAnimations.append(transitionTypeWithDirections(forName: "SystemFlip"))
    transitionAnimationsHeaders.append("SystemMoveIn")
    transitionAnimations.append(transitionTypeWithDirections(forName: "SystemMoveIn"))
    transitionAnimationsHeaders.append("SystemPush")
    transitionAnimations.append(transitionTypeWithDirections(forName: "SystemPush"))
    transitionAnimationsHeaders.append("SystemReveal")
    transitionAnimations.append(transitionTypeWithDirections(forName: "SystemReveal"))
    transitionAnimationsHeaders.append("SystemPage")
    transitionAnimations.append(["SystemPage(Curl)", "SystemPage(UnCurl)"])
    transitionAnimationsHeaders.append("SystemCameraIris")
    transitionAnimations.append(["SystemCameraIris", "SystemCameraIris(HollowOpen)", "SystemCameraIris(HollowClose)"])
    transitionAnimationsHeaders.append("Fold")
    transitionAnimations.append(transitionTypeWithDirections(forName: "Fold"))
    transitionAnimationsHeaders.append("Portal")
    transitionAnimations.append(["Portal(Forward,0.3)", "Portal(Backward)"])
    transitionAnimationsHeaders.append("NatGeo")
    transitionAnimations.append(["NatGeo(Left)", "NatGeo(Right)"])
    transitionAnimationsHeaders.append("Turn")
    transitionAnimations.append(transitionTypeWithDirections(forName: "Turn"))
    transitionAnimationsHeaders.append("Cards")
    transitionAnimations.append(["Cards(Forward)", "Cards(Backward)"])
    transitionAnimationsHeaders.append("Flip")
    transitionAnimations.append(["Flip(Left)", "Flip(Right)"])
    transitionAnimationsHeaders.append("Slide")
    transitionAnimations.append(["Slide(Left, fade)", "Slide(Right)", "Slide(Top, fade)", "Slide(Bottom)"])
    transitionAnimationsHeaders.append("Others")
    transitionAnimations.append(["SystemRotate", "SystemRippleEffect", "SystemSuckEffect", "Explode(10,-10,10)"])

  }
  
  func transitionTypeWithDirections(forName prefixName: String) -> [String] {
    return [prefixName + "(Left)", prefixName + "(Right)", prefixName + "(Top)", prefixName + "(Bottom)"]
  }
  
}

// MARK: - UITableViewDataSource / UITableViewDelegate

extension TransitionTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return transitionAnimations.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return transitionAnimations[section].count
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return transitionAnimationsHeaders[section]
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("transitionCell", forIndexPath: indexPath) as UITableViewCell
    cell.textLabel?.text = transitionAnimations[indexPath.section][indexPath.row]
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
