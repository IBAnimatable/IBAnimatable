//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class AnimatablePresentationController: UIPresentationController {

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
    if let _ =  presentedSetup.blurEffectStyle {
      dimmingView.blurEffectStyle = presentedSetup.blurEffectStyle
      dimmingView.blurOpacity = presentedSetup.blurOpacity
    } else {
      dimmingView.fillColor = presentedSetup.backgroundColor.colorWithAlphaComponent(presentedSetup.opacity)
    }
  }

  private func setupPresentedView() {
    presentedViewController.view.layer.cornerRadius = presentedSetup.cornerRadius
    presentedViewController.view.layer.masksToBounds = true
    if presentedSetup.shadowRadius > 0 {
      presentedViewController.view.layer.shadowOffset.width = presentedSetup.shadowOffset.x
      presentedViewController.view.layer.shadowOffset.height = presentedSetup.shadowOffset.y
      presentedViewController.view.layer.shadowRadius = presentedSetup.shadowRadius
      presentedViewController.view.layer.shadowOpacity = Float(presentedSetup.shadowOpacity)
      presentedViewController.view.layer.masksToBounds = false
    }
  }

  // MARK: Actions

  func chromeViewTapped(gesture: UIGestureRecognizer) {
    if gesture.state == .Ended && presentedSetup.dismissOnTap {
      presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
  }

}

// MARK: - Sizing Helper's

private extension AnimatablePresentationController {

  private func modalSize() -> CGSize {
    guard let containerSize = containerView?.bounds.size else {
      return CGSize.zero
    }

    let width = CGFloat(presentedSetup.modalSize.0.width(containerSize))
    let height = CGFloat(presentedSetup.modalSize.1.height(containerSize))
    return CGSize(width: width, height: height)
  }

  private func modalCenter() -> CGPoint? {
    guard let containerBounds = containerView?.bounds else {
      return nil
    }

    return presentedSetup.modalPosition.calculateCenter(containerBounds, modalSize: modalSize())
  }

  private func modalOrigin() -> CGPoint? {
    return presentedSetup.modalPosition.calculateOrigin()
  }

  private func calculateOrigin(center: CGPoint, size: CGSize) -> CGPoint {
    let x: CGFloat = center.x - size.width / 2
    let y: CGFloat = center.y - size.height / 2
    return CGPoint(x: x, y: y)
  }

}

// MARK: - UIPresentationController

public extension AnimatablePresentationController {

  // MARK: Presentation

  override func frameOfPresentedViewInContainerView() -> CGRect {
    guard let containerBounds = containerView?.bounds else {
      return CGRect.zero
    }

    var presentedViewFrame = CGRect.zero
    let size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerBounds.size)
    let origin: CGPoint
    if let center = modalCenter() {
      origin = calculateOrigin(center, size: size)
    } else {
      origin = modalOrigin() ?? CGPoint.zero
    }

    presentedViewFrame.size = size
    presentedViewFrame.origin = origin
    return presentedViewFrame
  }

  override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
    return modalSize()
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
