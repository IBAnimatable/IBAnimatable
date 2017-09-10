//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/// `AnimatablePresentationController` is a subclass of `UIPresentationController` with `PresentationConfiguration` to specify the dimming view and modal view for presentation.
public class AnimatablePresentationController: UIPresentationController {

  // MARK: Properties

  fileprivate let presentationConfiguration: PresentationConfiguration
  fileprivate var dimmingView = AnimatableView()
  fileprivate var presentationBackgroundView = PresentationBackgroundView()

  fileprivate var containerFrame: CGRect {
    return presentationConfiguration.contextFrameForPresentation ?? containerView?.bounds ?? .zero
  }

  // MARK: Init

  init(presentedViewController: UIViewController,
       presentingViewController: UIViewController?,
       presentationConfiguration: PresentationConfiguration) {
    self.presentationConfiguration = presentationConfiguration
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

    configureDimmingView()
    configurePresentedView()
    configureObservers()
  }

  deinit {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }

  // MARK: Actions

  @objc func dimmingViewTapped(gesture: UIGestureRecognizer) {
    if gesture.state == .ended && presentationConfiguration.dismissOnTap {
      presentingViewController.dismiss(animated: true, completion: nil)
    }
  }

}

// MARK: - Setup

private extension AnimatablePresentationController {

  func configureDimmingView() {
    var tap = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped))
    dimmingView.addGestureRecognizer(tap)
    tap = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped))
    presentationBackgroundView.addGestureRecognizer(tap)

    if let blurEffectStyle = presentationConfiguration.blurEffectStyle {
      dimmingView.blurEffectStyle = blurEffectStyle
      dimmingView.blurOpacity = presentationConfiguration.blurOpacity
    } else {
      dimmingView.fillColor = presentationConfiguration.backgroundColor.withAlphaComponent(presentationConfiguration.opacity)
    }
  }

  func configurePresentedView() {
    if presentationConfiguration.cornerRadius > 0 {
      presentedViewController.view.layer.cornerRadius = presentationConfiguration.cornerRadius
      presentedViewController.view.layer.masksToBounds = true
    }

    // Set up shadow
    presentedViewController.view.layer.shadowOffset.width = presentationConfiguration.shadowOffset.x
    presentedViewController.view.layer.shadowOffset.height = presentationConfiguration.shadowOffset.y
    presentedViewController.view.layer.shadowOpacity = Float(presentationConfiguration.shadowOpacity)
    if let shadowColor = presentationConfiguration.shadowColor, presentedViewController.view.layer.shadowRadius > 0 {
      presentedViewController.view.layer.shadowRadius = presentationConfiguration.shadowRadius
      presentedViewController.view.layer.shadowColor = shadowColor.cgColor
      presentedViewController.view.layer.masksToBounds = false
    }
  }

}

// MARK: - Notifications

extension AnimatablePresentationController {

  fileprivate func configureObservers() {
    guard presentationConfiguration.keyboardTranslation != .none else {
      return
    }

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
  }

  @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      let presentedFrame = frameOfPresentedViewInContainerView
      let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue ?? 0.5
      let translatedFrame = presentationConfiguration.keyboardTranslation.translationFrame(keyboardFrame: keyboardFrame,
                                                                                           presentedFrame: presentedFrame)

      let curve = UIViewAnimationOptions(rawValue: UInt(duration))
      UIView.animate(withDuration: duration, delay: 0, options: curve, animations: {
        self.presentedView?.frame = translatedFrame
      }, completion: nil)
    }
  }

  @objc func keyboardWillHide(notification: NSNotification) {
    let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue ?? 0.5
    let curve = UIViewAnimationOptions(rawValue: UInt(duration))
    UIView.animate(withDuration: duration, delay: 0, options: curve, animations: {
      self.presentedView!.frame = self.frameOfPresentedViewInContainerView
    }, completion: nil)
  }

}

// MARK: - Size & origin helpers

private extension AnimatablePresentationController {

  var modalSize: CGSize {
    let containerSize = containerFrame.size
    let width = CGFloat(presentationConfiguration.modalSize.0.width(parentSize: containerSize))
    let height = CGFloat(presentationConfiguration.modalSize.1.height(parentSize: containerSize))
    return CGSize(width: width, height: height)
  }

  var modalCenter: CGPoint? {
    return presentationConfiguration.modalPosition.modalCenter(in: containerFrame, modalSize: modalSize)
  }

  var modalOrigin: CGPoint? {
    return presentationConfiguration.modalPosition.calculateOrigin()
  }

  func calculateOrigin(center: CGPoint, size: CGSize) -> CGPoint {
    let x: CGFloat = center.x - size.width / 2
    let y: CGFloat = center.y - size.height / 2
    return CGPoint(x: x, y: y)
  }

}

// MARK: - UIPresentationController

public extension AnimatablePresentationController {

  // MARK: Presentation

  public override var frameOfPresentedViewInContainerView: CGRect {
    let containerBounds = containerFrame
    var presentedViewFrame = CGRect.zero
    let sizeForChildContentContainer = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
    let origin: CGPoint
    if let center = modalCenter {
      origin = calculateOrigin(center: center, size: sizeForChildContentContainer)
    } else {
      origin = modalOrigin ?? .zero
    }

    presentedViewFrame.size = sizeForChildContentContainer
    presentedViewFrame.origin = origin
    return presentedViewFrame
  }

  override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
    return modalSize
  }

  override func containerViewWillLayoutSubviews() {
    dimmingView.frame = containerFrame
    presentedView?.frame = frameOfPresentedViewInContainerView
  }

  // MARK: Animation

  override func presentationTransitionWillBegin() {
    presentationBackgroundView.frame = containerView?.bounds ?? .zero
    presentationBackgroundView.passthroughViews = presentingViewController.view.subviews
    containerView?.insertSubview(presentationBackgroundView, at: 0)

    dimmingView.frame = containerFrame
    dimmingView.alpha = 0.0
    containerView?.insertSubview(dimmingView, at: 1)

    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 1.0
      }, completion: nil)
    } else {
      dimmingView.alpha = 1.0
    }
  }

  public override func presentationTransitionDidEnd(_ completed: Bool) {
    if !completed {
      dimmingView.removeFromSuperview()
    }
  }

  override func dismissalTransitionWillBegin() {
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 0.0
      }, completion: nil)
    } else {
      dimmingView.alpha = 0.0
    }
  }

  public override func dismissalTransitionDidEnd(_ completed: Bool) {
    if completed {
      dimmingView.removeFromSuperview()
    }
  }
}
