//
//  PresentationAnimatable.swift
//  IBAnimatableApp
//

import UIKit

public class PresentationAnimatable: UIPresentationController {

  // MARK: Properties

  private let roundCorners: Bool
  private let dismissOnTap: Bool
  private var chromeView = UIView()

  // MARK: Init

  init(presentedViewController: UIViewController,
       presentingViewController: UIViewController,
       presenterSetup: PresentedSetup) {

    self.roundCorners = presenterSetup.roundCorners
    self.dismissOnTap = presenterSetup.dismissOnTap
    super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)

    setupChromeView(presenterSetup.backgroundColor, backgroundOpacity: presenterSetup.backgroundOpacity)
    if presenterSetup.roundCorners {
      addCornerRadiusToPresentedView()
    } else {
      removeCornerRadiusFromPresentedView()
    }
  }

  // MARK: Setup

  private func setupChromeView(backgroundColor: UIColor, backgroundOpacity: Float) {
    let tap = UITapGestureRecognizer(target: self, action: #selector(chromeViewTapped))
    chromeView.addGestureRecognizer(tap)
    chromeView.backgroundColor = backgroundColor.colorWithAlphaComponent(CGFloat(backgroundOpacity))
  }

  private func addCornerRadiusToPresentedView() {
    presentedViewController.view.layer.cornerRadius = 4
    presentedViewController.view.layer.masksToBounds = true
  }

  private func removeCornerRadiusFromPresentedView() {
    presentedViewController.view.layer.cornerRadius = 0
  }

  // MARK: Actions

  func chromeViewTapped(gesture: UIGestureRecognizer) {
    if gesture.state == .Ended && dismissOnTap {
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
    chromeView.frame = containerView?.bounds ?? CGRect.zero
    presentedView()?.frame = frameOfPresentedViewInContainerView()
  }

  // MARK: Animation

  override func presentationTransitionWillBegin() {
    chromeView.frame = containerView?.bounds ?? CGRect.zero
    chromeView.alpha = 0.0
    containerView?.insertSubview(chromeView, atIndex: 0)
    if let coordinator = presentedViewController.transitionCoordinator() {
      coordinator.animateAlongsideTransition({ _ in
        self.chromeView.alpha = 1.0
      }, completion: nil)
    } else {
      chromeView.alpha = 1.0
    }
  }

  override func dismissalTransitionWillBegin() {
    if let coordinator = presentedViewController.transitionCoordinator() {
      coordinator.animateAlongsideTransition({ _ in
        self.chromeView.alpha = 0.0
      }, completion: nil)
    } else {
      chromeView.alpha = 0.0
    }
  }

}
