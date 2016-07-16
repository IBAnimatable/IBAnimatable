//
//  Created by Jake Lin on 12/14/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

@IBDesignable public class AnimatableViewController: UIViewController, ViewControllerDesignable, StatusBarDesignable, RootWindowDesignable, TransitionAnimatable {
  // MARK: - ViewControllerDesignable
  @IBInspectable public var hideNavigationBar: Bool = false
  
  // MARK: - StatusBarDesignable
  @IBInspectable public var lightStatusBar: Bool = false
  
  // MARK: - RootWindowDesignable
  @IBInspectable public var rootWindowBackgroundColor: UIColor?

  // MARK: - TransitionAnimatable
  @IBInspectable public var transitionAnimationType: String?
  @IBInspectable public var transitionDuration: Double = .NaN
  @IBInspectable public var interactiveGestureType: String?

  // MARK: - Lifecylce
  public override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    confingHideNavigationBar()
    configRootWindowBackgroundColor()
  }
  
  public override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    resetHideNavigationBar()
  }
  
  public override func preferredStatusBarStyle() -> UIStatusBarStyle {
    if lightStatusBar {
      return .LightContent
    }
    return .Default
  }

  public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    // Configure custom transition animation
    guard let transitionAnimationType = transitionAnimationType, animationType = TransitionAnimationType.fromString(transitionAnimationType) else {
      return
    }

    let toViewController = segue.destinationViewController
    // If interactiveGestureType has been set
    if let interactiveGestureType = interactiveGestureType, interactiveGestureTypeValue = InteractiveGestureType.fromString(interactiveGestureType) {
      toViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(animationType, transitionDuration: transitionDuration, interactiveGestureType: interactiveGestureTypeValue)
    } else if let _ = segue.destinationViewController as? PresentationDesignable {
      setupPresented(toViewController, animationType: animationType)
    } else {
      toViewController.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(animationType, transitionDuration: transitionDuration)
    }
  }

  private func setupPresented(presentedVC: UIViewController, animationType: TransitionAnimationType) {
    guard let presentationDesignable = presentedVC as? PresentationDesignable else {
      return
    }

    var presenterSetup = PresentedSetup()
    presenterSetup.roundCorners = presentationDesignable.roundCorners
    presenterSetup.dismissOnTap = presentationDesignable.dismissOnTap
    presenterSetup.backgroundColor = presentationDesignable.backgroundColor
    presenterSetup.backgroundOpacity = presentationDesignable.backgroundOpacity

    presentedVC.transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(animationType, transitionDuration: transitionDuration, presenterSetup: presenterSetup)
    presentedVC.modalPresentationStyle = .Custom
  }

  public func customPresent(presentedVC presentedVC: AnimatablePresentedViewController) {
    setupPresented(presentedVC, animationType: .Fade(direction: .In))
    presentViewController(presentedVC, animated: true, completion: nil)
  }
}
