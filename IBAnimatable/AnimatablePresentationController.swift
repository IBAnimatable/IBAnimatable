//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/// `AnimatablePresentationController` is a subclass of `UIPresentationController` with `PresentationConfiguration` to specify the dimming view and modal view for presentation.
public class AnimatablePresentationController: UIPresentationController {

  // MARK: Properties

  private let presentationConfiguration: PresentationConfiguration
  private var dimmingView = AnimatableView()

  // MARK: Init

  init(presentedViewController: UIViewController,
       presentingViewController: UIViewController,
       presentationConfiguration: PresentationConfiguration) {
    self.presentationConfiguration = presentationConfiguration
    super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)

    setupDimmingView()
    setupPresentedView()
    setupObservers()
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)    
  }

  // MARK: Actions

  func chromeViewTapped(gesture: UIGestureRecognizer) {
    if gesture.state == .Ended && presentationConfiguration.dismissOnTap {
      presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
  }

}

// MARK: - Setup

private extension AnimatablePresentationController {

  func setupDimmingView() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(chromeViewTapped))
    dimmingView.addGestureRecognizer(tap)
    if let blurEffectStyle =  presentationConfiguration.blurEffectStyle {
      dimmingView.blurEffectStyle = blurEffectStyle
      dimmingView.blurOpacity = presentationConfiguration.blurOpacity
    } else {
      dimmingView.fillColor = presentationConfiguration.backgroundColor.colorWithAlphaComponent(presentationConfiguration.opacity)
    }
  }
  
  func setupPresentedView() {
    if presentationConfiguration.cornerRadius > 0 {
      presentedViewController.view.layer.cornerRadius = presentationConfiguration.cornerRadius
      presentedViewController.view.layer.masksToBounds = true
    }
    
    // Set up shadow
    if presentationConfiguration.shadowRadius > 0 {
      presentedViewController.view.layer.shadowRadius = presentationConfiguration.shadowRadius
      presentedViewController.view.layer.masksToBounds = false
    }
    
    if !presentationConfiguration.shadowOffset.x.isNaN && !presentationConfiguration.shadowOffset.y.isNaN {
      presentedViewController.view.layer.shadowOffset.width = presentationConfiguration.shadowOffset.x
      presentedViewController.view.layer.shadowOffset.height = presentationConfiguration.shadowOffset.y
      presentedViewController.view.layer.masksToBounds = false
    }
    
    if presentationConfiguration.shadowOpacity > 0 {
      presentedViewController.view.layer.shadowOpacity = Float(presentationConfiguration.shadowOpacity)
      presentedViewController.view.layer.masksToBounds = false
    }
    
    if let shadowColor = presentationConfiguration.shadowColor {
      presentedViewController.view.layer.shadowColor = shadowColor.CGColor
      presentedViewController.view.layer.masksToBounds = false
    }
  }

}

// MARK: - Notifications

extension AnimatablePresentationController {

  private func setupObservers() {
    guard presentationConfiguration.keyboardTranslation != .None else {
      return
    }

    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AnimatablePresentationController.keyboardWasShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AnimatablePresentationController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
  } 

  func keyboardWasShown (notification: NSNotification) {
    if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue() {
      let presentedFrame = frameOfPresentedViewInContainerView()
      let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue ?? 0.5
      let translatedFrame = presentationConfiguration.keyboardTranslation.translationFrame(keyboardFrame, presentedFrame: presentedFrame)

      let curve = UIViewAnimationOptions(rawValue: UInt(duration))
      UIView.animateWithDuration(duration, delay: 0, options: curve, animations: {
        self.presentedView()?.frame = translatedFrame
      }, completion: nil)
    }
  }

  func keyboardWillHide (notification: NSNotification) {    
    let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue ?? 0.5
    let curve = UIViewAnimationOptions(rawValue: UInt(duration))
    UIView.animateWithDuration(duration, delay: 0, options: curve, animations: {
      self.presentedView()!.frame = self.frameOfPresentedViewInContainerView()
    }, completion: nil)
  }

}

// MARK: - Size & origin helpers

private extension AnimatablePresentationController {

  func modalSize() -> CGSize {
    guard let containerSize = containerView?.bounds.size else {
      return CGSize.zero
    }

    let width = CGFloat(presentationConfiguration.modalSize.0.width(containerSize))
    let height = CGFloat(presentationConfiguration.modalSize.1.height(containerSize))
    return CGSize(width: width, height: height)
  }

  func modalCenter() -> CGPoint? {
    guard let containerBounds = containerView?.bounds else {
      return nil
    }

    return presentationConfiguration.modalPosition.calculateCenter(containerBounds, modalSize: modalSize())
  }

  func modalOrigin() -> CGPoint? {
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
