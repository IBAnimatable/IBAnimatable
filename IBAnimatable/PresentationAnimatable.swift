//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class PresentationAnimatable: UIPresentationController {

  // MARK: Properties

  private let presentedSetup: PresentedSetup
  private var dimmingView = AnimatableView()

  // MARK: Init

  init(presentedViewController: UIViewController,
       presentingViewController: UIViewController,
       presentedSetup: PresentedSetup) {
    self.presentedSetup = presentedSetup
    super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)

    setupDimmingView()
    setupPresentedView()
  }

  // MARK: Setup

  private func setupDimmingView() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(chromeViewTapped))
    dimmingView.addGestureRecognizer(tap)
    dimmingView.fillColor = presentedSetup.backgroundColor.colorWithAlphaComponent(presentedSetup.opacity)
  }

  private func setupPresentedView() {
    presentedViewController.view.layer.cornerRadius = presentedSetup.cornerRadius
    presentedViewController.view.layer.masksToBounds = true
  }

  // MARK: Actions

  func chromeViewTapped(gesture: UIGestureRecognizer) {
    if gesture.state == .Ended && presentedSetup.dismissOnTap {
      presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
  }

}

// MARK: - Sizing Helper's

private extension PresentationAnimatable {

  private func centerPoint() -> CGPoint? {
    guard let containerBounds = containerView?.bounds else {
      return nil
    }
    return CGPoint(x: containerBounds.width / 2, y: containerBounds.height / 2)
  }

  private func calculateOrigin(center: CGPoint, size: CGSize) -> CGPoint {
    let x: CGFloat = center.x - size.width / 2
    let y: CGFloat = center.y - size.height / 2
    return CGPoint(x: x, y: y)
  }

}

// MARK: - UIPresentationController

public extension PresentationAnimatable {

  // MARK: Presentation

  override func frameOfPresentedViewInContainerView() -> CGRect {
    var presentedViewFrame = CGRect.zero
    let size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerView?.bounds.size ?? CGSize.zero)
    presentedViewFrame.size = size
    presentedViewFrame.origin = centerPoint() ?? CGPoint.zero
    return presentedViewFrame
  }

  override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
    let width = 200
    let height = 200
    return CGSize(width: CGFloat(width), height: CGFloat(height))
  }

  override func containerViewWillLayoutSubviews() {
    dimmingView.frame = containerView?.bounds ?? CGRect.zero
    presentedView()?.frame = frameOfPresentedViewInContainerView()
  }

  // MARK: Animation

  override func presentationTransitionWillBegin() {
    dimmingView.frame = containerView?.bounds ?? CGRect.zero
    dimmingView.alpha = 0.0
    containerView?.insertSubview(dimmingView, atIndex: 0)
    if let coordinator = presentedViewController.transitionCoordinator() {
      coordinator.animateAlongsideTransition({ _ in
        self.dimmingView.alpha = 1.0
      }, completion: nil)
    } else {
      dimmingView.alpha = 1.0
    }
  }

  public override func presentationTransitionDidEnd(completed: Bool) {
    if !completed {
      dimmingView.removeFromSuperview()
    }
  }

  override func dismissalTransitionWillBegin() {
    if let coordinator = presentedViewController.transitionCoordinator() {
      coordinator.animateAlongsideTransition({ _ in
        self.dimmingView.alpha = 0.0
      }, completion: nil)
    } else {
      dimmingView.alpha = 0.0
    }
  }

  public override func dismissalTransitionDidEnd(completed: Bool) {
    if completed {
      dimmingView.removeFromSuperview()
    }
  }
}
