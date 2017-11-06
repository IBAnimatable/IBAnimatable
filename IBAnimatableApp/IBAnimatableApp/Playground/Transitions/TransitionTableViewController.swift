//
//  Created by Jake Lin on 2/29/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class TransitionTableViewController: UITableViewController {

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

    let fadeAnimations: [TransitionAnimationType] = [.fade(direction: .in),
                                                     .fade(direction: .out),
                                                     .fade(direction: .cross)]

    transitionAnimations.append(toString(animations: fadeAnimations))

    transitionAnimationsHeaders.append("SystemCube")

    let cubeAnimations: [TransitionAnimationType] = [.systemCube(from: .left),
                                                     .systemCube(from: .right),
                                                     .systemCube(from: .top),
                                                     .systemCube(from: .bottom)]

    transitionAnimations.append(toString(animations: cubeAnimations))

    transitionAnimationsHeaders.append("SystemFlip")

    let flipSystemAnimations: [TransitionAnimationType] = [.systemFlip(from: .left),
                                                           .systemFlip(from: .right),
                                                           .systemFlip(from: .top),
                                                           .systemFlip(from: .bottom)]

    transitionAnimations.append(toString(animations: flipSystemAnimations))

    transitionAnimationsHeaders.append("SystemMoveIn")

    let moveAnimations: [TransitionAnimationType] = [.systemMoveIn(from: .left),
                                                     .systemMoveIn(from: .right),
                                                     .systemMoveIn(from: .top),
                                                     .systemMoveIn(from: .bottom)]

    transitionAnimations.append(toString(animations: moveAnimations))

    transitionAnimationsHeaders.append("SystemPush")

    let pushAnimations: [TransitionAnimationType] = [.systemPush(from: .left),
                                                     .systemPush(from: .right),
                                                     .systemMoveIn(from: .top),
                                                     .systemMoveIn(from: .bottom)]

    transitionAnimations.append(toString(animations: pushAnimations))

    transitionAnimationsHeaders.append("SystemReveal")

    let revealAnimations: [TransitionAnimationType] = [.systemReveal(from: .left),
                                                       .systemReveal(from: .right),
                                                       .systemReveal(from: .top),
                                                       .systemReveal(from: .bottom)]

    transitionAnimations.append(toString(animations: revealAnimations))

    transitionAnimationsHeaders.append("SystemPage")

    let pageAnimations: [TransitionAnimationType] = [.systemPage(type: .curl), .systemPage(type: .unCurl)]

    transitionAnimations.append(toString(animations: pageAnimations))

    transitionAnimationsHeaders.append("SystemCameraIris")

    let cameraAnimations: [TransitionAnimationType] = [.systemCameraIris(hollowState: .none),
                                                       .systemCameraIris(hollowState: .open),
                                                       .systemCameraIris(hollowState: .close)]

    transitionAnimations.append(toString(animations: cameraAnimations))

    transitionAnimationsHeaders.append("Fold")

    let foldAnimations: [TransitionAnimationType] = [.fold(from: .left, folds: nil),
                                                     .fold(from: .right, folds: nil),
                                                     .fold(from: .top, folds: nil),
                                                     .fold(from: .bottom, folds: nil)]

    transitionAnimations.append(toString(animations: foldAnimations))

    transitionAnimationsHeaders.append("Portal")

    let portalAnimations: [TransitionAnimationType] = [.portal(direction: .forward, zoomScale: 0.3),
                                                       .portal(direction: .backward, zoomScale: nil)]

    transitionAnimations.append(toString(animations: portalAnimations))

    transitionAnimationsHeaders.append("NatGeo")

    let natGeoAnimations: [TransitionAnimationType] = [.natGeo(to: .left), .natGeo(to: .right)]

    transitionAnimations.append(toString(animations: natGeoAnimations))

    transitionAnimationsHeaders.append("Turn")

    let turnAnimations: [TransitionAnimationType] = [.turn(from: .left),
                                                     .turn(from: .right),
                                                     .turn(from: .top),
                                                     .turn(from: .bottom)]

    transitionAnimations.append(toString(animations: turnAnimations))

    transitionAnimationsHeaders.append("Cards")

    let cardAnimations: [TransitionAnimationType] = [.cards(direction: .forward), .cards(direction: .backward)]

    transitionAnimations.append(toString(animations: cardAnimations))

    transitionAnimationsHeaders.append("Flip")

    let flipAnimations: [TransitionAnimationType] = [.flip(from: .left), .flip(from: .right)]

    transitionAnimations.append(toString(animations: flipAnimations))

    transitionAnimationsHeaders.append("Slide")

    let slideAnimations: [TransitionAnimationType] = [.slide(to: .left, isFade: true),
                                                      .slide(to: .right, isFade: false),
                                                      .slide(to: .top, isFade: true),
                                                      .slide(to: .bottom, isFade: false)]

    transitionAnimations.append(toString(animations: slideAnimations))

    transitionAnimationsHeaders.append("Others")
    let otherAnimations: [TransitionAnimationType] = [.systemRotate,
                                                      .systemRippleEffect,
                                                      .explode(xFactor: nil, minAngle: nil, maxAngle: nil),
                                                      .explode(xFactor: 10, minAngle: -20, maxAngle: 20)]

    transitionAnimations.append(toString(animations: otherAnimations))
  }

  private func toString(animations: [TransitionAnimationType]) -> [String] {
    return animations.map { $0.asString }
  }

}

fileprivate extension TransitionAnimationType {

  var asString: String {
    switch self {
    case .fade(let direction):
      return "fade" + "(\(direction.rawValue))"
    case .systemCube(let direction):
      return "systemCube" + "(\(direction.rawValue))"
    case .systemFlip(let direction):
      return "systemFlip" + "(\(direction.rawValue))"
    case .systemMoveIn(let direction):
      return "systemMoveIn" + "(\(direction.rawValue))"
    case .systemPush(let direction):
      return "systemPush" + "(\(direction.rawValue))"
    case .systemReveal(let direction):
      return "systemReveal" + "(\(direction.rawValue))"
    case .systemPage(let type):
      return "systemPage(\(type.rawValue))"
    case .systemCameraIris(let hollowState):
      return "systemCameraIris" + (hollowState == .none ? "" : "(\(hollowState.rawValue))")
    case .fold(let direction, _):
      return "fold" + "(\(direction.rawValue))"
    case let .portal(direction, zoomScale):
      return "portal" + (zoomScale == nil ? "(\(direction.rawValue))" : "(\(direction.rawValue),\(zoomScale!))")
    case .natGeo(let direction):
      return "natGeo" + "(\(direction.rawValue))"
    case .turn(let direction):
      return "turn" + "(\(direction.rawValue))"
    case .cards(let direction):
      return "cards" + "(\(direction.rawValue))"
    case .flip(let direction):
      return "flip" + "(\(direction.rawValue))"
    case let .slide(direction, isFade):
      return "slide" + (isFade ? "(\(direction.rawValue), fade)" : "slide" + "(\(direction.rawValue))")
    case .systemRotate:
      return "systemRotate"
    case .systemRippleEffect:
      return "systemRippleEffect"
    case .systemSuckEffect:
      return "systemSuckEffect"
    case let .explode(.some(x), .some(min), .some(max)):
      return "explode" + "(\(x),\(min),\(max))"
    case .explode:
      return "explode"
    case .none:
      return "none"
    }
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
      header.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
    }
  }
}
