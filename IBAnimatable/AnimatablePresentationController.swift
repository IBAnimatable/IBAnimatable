//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class AnimatablePresentationController: UIPresentationController {

  // MARK: Properties

  private let presentionConfiguration: PresentionConfiguration
  private var dimmingView = AnimatableView()

  // MARK: Init

  init(presentedViewController: UIViewController,
       presentingViewController: UIViewController,
       presentionConfiguration: PresentionConfiguration) {
    self.presentionConfiguration = presentionConfiguration
    super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)

    setupDimmingView()
    setupPresentedView()
  }

  // MARK: Setup

  private func setupDimmingView() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(chromeViewTapped))
    dimmingView.addGestureRecognizer(tap)
    if let blurEffectStyle =  presentionConfiguration.blurEffectStyle {
      dimmingView.blurEffectStyle = blurEffectStyle
      dimmingView.blurOpacity = presentionConfiguration.blurOpacity
    } else {
      dimmingView.fillColor = presentionConfiguration.backgroundColor.colorWithAlphaComponent(presentionConfiguration.opacity)
    }
  }

  private func setupPresentedView() {
    presentedViewController.view.layer.cornerRadius = presentionConfiguration.cornerRadius
    presentedViewController.view.layer.masksToBounds = true
    if presentionConfiguration.shadowRadius > 0 {
      presentedViewController.view.layer.shadowOffset.width = presentionConfiguration.shadowOffset.x
      presentedViewController.view.layer.shadowOffset.height = presentionConfiguration.shadowOffset.y
      presentedViewController.view.layer.shadowRadius = presentionConfiguration.shadowRadius
      presentedViewController.view.layer.shadowOpacity = Float(presentionConfiguration.shadowOpacity)
      presentedViewController.view.layer.masksToBounds = false
    }
  }

  // MARK: Actions

  func chromeViewTapped(gesture: UIGestureRecognizer) {
    if gesture.state == .Ended && presentionConfiguration.dismissOnTap {
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

    let width = CGFloat(presentionConfiguration.modalSize.0.width(containerSize))
    let height = CGFloat(presentionConfiguration.modalSize.1.height(containerSize))
    return CGSize(width: width, height: height)
  }

  private func modalCenter() -> CGPoint? {
    guard let containerBounds = containerView?.bounds else {
      return nil
    }

    return presentionConfiguration.modalPosition.calculateCenter(containerBounds, modalSize: modalSize())
  }

  private func modalOrigin() -> CGPoint? {
    return presentionConfiguration.modalPosition.calculateOrigin()
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
    dimmingView.frame = containerView?.bounds ?? .zero
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
