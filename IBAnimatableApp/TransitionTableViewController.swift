//
//  Created by Jake Lin on 2/29/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
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
    toNavigationController.transitionAnimationType = transitionAnimationType
    
    if let transitionViewController = toNavigationController.topViewController as? TransitionViewController {
      transitionViewController.animationType = transitionAnimationType
    }
  }

}

// MARK: - Factory

private extension TransitionTableViewController {
  
  func generateTransitionTypeData() {
    transitionAnimationsHeaders.append("ContainerTransition")
    transitionAnimations.append(["TabBar example"])
    transitionAnimationsHeaders.append("Fade")
    transitionAnimations.append(["Fade", "FadeIn", "FadeOut"])
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
    transitionAnimationsHeaders.append("SystemRotate")
    transitionAnimations.append(["SystemRotate(90)", "SystemRotate(90ccw)", "SystemRotate(180)", "SystemRotate(180ccw)"])
    transitionAnimationsHeaders.append("Fold")
    transitionAnimations.append(transitionTypeWithDirections(forName: "Fold"))
    transitionAnimationsHeaders.append("Portal")
    transitionAnimations.append(["Portal(Forward,0.3)", "Portal(Backward)"])
    transitionAnimationsHeaders.append("NatGeo")
    transitionAnimations.append(["NatGeo(Left)", "NatGeo(Right)"])
    transitionAnimationsHeaders.append("Turn")
    transitionAnimations.append(transitionTypeWithDirections(forName: "Turn"))
    transitionAnimationsHeaders.append("Cards")
    transitionAnimations.append(transitionTypeWithDirections(forName: "Cards"))
    transitionAnimationsHeaders.append("Flip")
    transitionAnimations.append(transitionTypeWithDirections(forName: "Flip"))
    transitionAnimationsHeaders.append("Slide")
    transitionAnimations.append(["Slide(Left, fade)", "Slide(Right)", "Slide(Top, fade)", "Slide(Bottom)"])
    transitionAnimationsHeaders.append("Others")
    transitionAnimations.append(["SystemRippleEffect", "SystemSuckEffect", "Explode(10,-10,10)"])

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
 
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if indexPath.section == 0 && indexPath.row == 0 {
      performSegueWithIdentifier("ContainerTransitionDemo", sender: self)
    } else {
      performSegueWithIdentifier("TransitionDemo", sender: self)
    }
  }
}
