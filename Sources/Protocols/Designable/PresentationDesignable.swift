//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public typealias ModalSize = (width: PresentationModalSize, height: PresentationModalSize)
/// PresentationDesignable is a protocol to define customised modal view controller which is used as the `presentedViewController` for `UIPresentationController`
public protocol PresentationDesignable: class {

  var presenter: PresentationPresenter? { get set }

  /// Frame of the presentingVC's dimmingView. Used that property if you want to simulate a presentation `overCurrentContext`. If nil, the dimmingView will be in fullscreen.
  var contextFrameForPresentation: (() -> CGRect)? { get set }

  /// Presentation animation type, all supported animation type can be found in `PresentationAnimationType`
  var presentationAnimationType: PresentationAnimationType { get set }

  /// Dismissal animation type, all supported animation type can be found in `PresentationAnimationType`
  var dismissalAnimationType: PresentationAnimationType { get set }
  /// Tranistion duration
  var transitionDuration: Double { get set }

  // Modal position, all supported modal position can be found in `PresentationModalPosition`
  var modalPosition: PresentationModalPosition { get set }

  // Modal Size, all supported modal Sizes can be found in `PresentationModalSize`
  var modalSize: ModalSize { get set }

  /// The corner radius of the modal view
  var cornerRadius: CGFloat { get set }

  /// If set to `true`, the modal view will dismiss when tap on the dimming view.
  var dismissOnTap: Bool { get set }

  /// The background color of the dimming view. The default value is black color.
  var backgroundColor: UIColor { get set }

  /// The opacity of the dimming view. The default value is `0.7`.
  var opacity: CGFloat { get set }

  /// The blur effect style of the dimming view. If use this property, `backgroundColor` and `opacity` are ignored.
  var blurEffectStyle: UIBlurEffect.Style? { get set }

  /// The blur opacity of the dimming view. If use this property, `backgroundColor` and `opacity` are ignored.
  var blurOpacity: CGFloat { get set }

  /// The shadow color of the modal view. If use this property, `cornerRadius` is ignored.
  var shadowColor: UIColor? { get set }

  /// The shadow radius of the modal view. If use this property, `cornerRadius` is ignored.
  var shadowRadius: CGFloat { get set }

  /// The shadow opacity of the modal view. If use this property, `cornerRadius` is ignored.
  var shadowOpacity: CGFloat { get set }

  /// The shadow offset of the modal view. If use this property, `cornerRadius` is ignored.
  var shadowOffset: CGPoint { get set }

  /// Modal's translation when the keyboard is opening
  var keyboardTranslation: ModalKeyboardTranslation { get set }

}

// MARK: - Configuration

public extension PresentationDesignable where Self: UIViewController {

  public func configurePresenter() {
    let presentationManager = PresentationPresenterManager.shared
    presenter = presentationManager.retrievePresenter(presentationAnimationType: presentationAnimationType,
                                                      transitionDuration: transitionDuration)
    presenter?.dismissalAnimationType = dismissalAnimationType
    transitioningDelegate = presenter
    modalPresentationStyle = .custom
    if let systemTransition = presentationAnimationType.systemTransition {
      modalTransitionStyle = systemTransition
    }

    let presentationConfiguration = PresentationConfiguration()
    presentationConfiguration.contextFrameForPresentation = contextFrameForPresentation?()
    presentationConfiguration.modalPosition = modalPosition
    presentationConfiguration.modalSize = modalSize
    presentationConfiguration.cornerRadius = cornerRadius
    presentationConfiguration.dismissOnTap = dismissOnTap
    presentationConfiguration.backgroundColor = backgroundColor
    presentationConfiguration.opacity = opacity
    presentationConfiguration.blurEffectStyle = blurEffectStyle
    presentationConfiguration.blurOpacity = blurOpacity
    presentationConfiguration.shadowColor = shadowColor
    presentationConfiguration.shadowOpacity = shadowOpacity
    presentationConfiguration.shadowRadius = shadowRadius
    presentationConfiguration.shadowOffset = shadowOffset
    presentationConfiguration.keyboardTranslation = keyboardTranslation
    presenter?.presentationConfiguration = presentationConfiguration
  }

  public func configureDismissalTransition() {
    let animationType = dismissalAnimationType
    if let dismissalSystemTransition = animationType.systemTransition {
      modalTransitionStyle = dismissalSystemTransition
    }
  }

  public func configurePresenterFrameForPresentation() {
       presenter?.presentationConfiguration?.contextFrameForPresentation = contextFrameForPresentation?()
  }

}

// MARK: - PresentationConfiguration

/// `PresentationConfiguration` a class is used for specifying the dimming view and modal view for `AnimatablePresentationController`
public class PresentationConfiguration {
  public var cornerRadius: CGFloat = .nan
  public var dismissOnTap: Bool = true
  public var backgroundColor: UIColor = .black
  public var opacity: CGFloat = 0.7
  public var blurEffectStyle: UIBlurEffect.Style?
  public var blurOpacity: CGFloat = .nan
  public var shadowColor: UIColor?
  public var shadowRadius: CGFloat = .nan
  public var shadowOpacity: CGFloat = 0.7
  public var shadowOffset: CGPoint = .zero
  public var modalPosition: PresentationModalPosition = .center
  public var modalSize: (PresentationModalSize, PresentationModalSize) = (.half, .half)
  public var keyboardTranslation = ModalKeyboardTranslation.none
  public var contextFrameForPresentation: CGRect?
}
