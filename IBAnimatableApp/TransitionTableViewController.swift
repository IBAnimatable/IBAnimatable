//
//  Created by Jake Lin on 2/29/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

class TransitionTableViewController: UITableViewController {

  fileprivate var transitionAnimationsHeaders = [String]()
  fileprivate var transitionAnimations = [[String]]()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    populateTransitionTypeData()
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    guard let toNavigationController = segue.destination as? AnimatableNavigationController, let indexPath = tableView.indexPathForSelectedRow else {
      return
    }
    let transitionString = transitionAnimations[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]

    let transitionAnimationType = TransitionAnimationType(string: transitionString)

    // Set the transition animation type for `AnimatableNavigationController`, used for Push/Pop transitions
    toNavigationController.transitionAnimationType = transitionAnimationType
    toNavigationController.navigationBar.topItem?.title = transitionString

    // Set the transition animation type for `AnimatableViewController`, used for Present/Dismiss transitions
    if let toViewController = toNavigationController.topViewController as? TransitionViewController {
      toViewController.transitionAnimationType = transitionAnimationType
    }
  }

}

// MARK: - Factory

private extension TransitionTableViewController {

  func populateTransitionTypeData() {
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
    transitionAnimations.append(["SystemRotate", "SystemRippleEffect", "SystemSuckEffect", "Explode", "Explode(10,-20,20)"])
  }

  func transitionTypeWithDirections(forName prefixName: String) -> [String] {
    return [prefixName + "(Left)", prefixName + "(Right)", prefixName + "(Top)", prefixName + "(Bottom)"]
  }

}

// MARK: - UITableViewDataSource / UITableViewDelegate

extension TransitionTableViewController {

  override func numberOfSections(in tableView: UITableView) -> Int {
    return transitionAnimations.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return transitionAnimations[section].count
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return transitionAnimationsHeaders[section]
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "transitionCell", for: indexPath) as UITableViewCell
    cell.textLabel?.text = transitionAnimations[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
    return cell
  }

  // MARK: - reset the group header font color and size
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    if let header = view as? UITableViewHeaderFooterView {
      header.textLabel?.textColor = .white
      header.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
    }
  }
}
