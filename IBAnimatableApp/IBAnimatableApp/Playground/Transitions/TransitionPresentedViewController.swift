//
//  Created by Jake Lin on 5/16/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class TransitionPresentedViewController: AnimatableViewController {

  @IBOutlet fileprivate var gestureLabel: UILabel!
  @IBOutlet fileprivate var presentViaSegueButton: AnimatableButton!
  @IBOutlet fileprivate var presentViaDismissInteractionSegueButton: AnimatableButton!

  var presentingSegueClass: UIStoryboardSegue.Type?
  var presentingWithDismissInteractionSegueClass: UIStoryboardSegue.Type?

  // Intenal use for demo only
  var useDismissInteraction: Bool = true

  override func viewDidLoad() {
    super.viewDidLoad()

    if let animatableView = view as? AnimatableView {
      animatableView.predefinedGradient = makeRandomGradient()
    }

    configureGestureLabel()
    prepareSegues()
    hideButtonsIfNeeded()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    // Set the transition animation type for `AnimatableViewController`, used for Present/Dismiss transitions
    if let toViewController = segue.destination as? AnimatableViewController {
      toViewController.transitionAnimationType = transitionAnimationType
      toViewController.interactiveGestureType = interactiveGestureType
    }
  }

  @IBAction func presentViaSegueDidTap(_ sender: AnyObject) {
    presentViaSegue(presentingSegueClass, useDismissInteraction: false)
  }

  @IBAction func presentViaDismissInteractionSegueDidTap(_ sender: AnyObject) {
    presentViaSegue(presentingWithDismissInteractionSegueClass, useDismissInteraction: true)
  }
}

private extension TransitionPresentedViewController {

  func configureGestureLabel() {
    // Shows nothing by default
    gestureLabel.text = ""

    // If `useDismissInteraction` is `false` then don't support gesture interaction
    guard useDismissInteraction else {
      return
    }

    // No gesture for this animator
    if case .none = interactiveGestureType {
      return
    }

    if case .none = transitionAnimationType {
      return
    }

    gestureLabel.text = retrieveGestureText(interactiveGestureType: interactiveGestureType,
                                            transitionAnimationType: transitionAnimationType,
                                            exit: "dismiss")
  }

  func prepareSegues() {
    if case .none = transitionAnimationType {
      return
    }

    // Set up the segue without dismissal interaction
    var segueName = "IBAnimatable.Present" + extractAnimationType(transitionAnimationType.stringValue.capitalized) + "Segue"

    if let segueClass = NSClassFromString(segueName) as? UIStoryboardSegue.Type {
      presentingSegueClass = segueClass
    }

    // Set up the segue with dismissal interaction
    segueName = "IBAnimatable.Present" + extractAnimationType(transitionAnimationType.stringValue.capitalized) + "WithDismissInteractionSegue"

    if let segueClass = NSClassFromString(segueName) as? UIStoryboardSegue.Type {
      presentingWithDismissInteractionSegueClass = segueClass
    }
  }

  func hideButtonsIfNeeded() {
    // Hide them if the segue(s) don't exist
    if presentingSegueClass == nil {
      presentViaSegueButton.alpha = 0
    }

    if presentingWithDismissInteractionSegueClass == nil {
      presentViaDismissInteractionSegueButton.alpha = 0
    }
  }

  // To extract the type without parameters
  func extractAnimationType(_ animationType: String) -> String {
    if let range = animationType.range(of: "(") {
      return String(animationType[..<range.lowerBound])
    }
    return animationType
  }

  func presentViaSegue(_ segueClass: UIStoryboardSegue.Type?, useDismissInteraction: Bool) {
    let presentedVC = storyboard?.instantiateViewController(withIdentifier: "TransitionPresentedViewController")
    if let segueClass = segueClass, let toViewController = presentedVC as? TransitionPresentedViewController {
      toViewController.useDismissInteraction = useDismissInteraction
      let segue = segueClass.init(identifier: String(describing: segueClass), source: self, destination: toViewController)
      prepare(for: segue, sender: self)
      segue.perform()
    }
  }

}
