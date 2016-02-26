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

  // MARK: - Lifecylce
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureTransitioningDelegate()
  }

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
    let toViewController = segue.destinationViewController
    toViewController.transitioningDelegate = presenter

    super.prepareForSegue(segue, sender: sender)
  }

  // MARK: - Private
  // Must have a property to keep the reference alive because `UIViewController.transitioningDelegate` is `weak`
  private var presenter: Presenter?

  private func configureTransitioningDelegate() {
    guard let transitionAnimationType = transitionAnimationType else {
      return
    }
    
    var duration = transitionDuration
    // Set the default duration for transition
    if transitionDuration.isNaN {
      duration = 0.35 
    }
    presenter = Presenter(transitionAnimationType: transitionAnimationType, transitionDuration: duration)
  }
}
