//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/// `AnimatableModalViewController` is a customised modal view controller used as the `presentedViewController` for `UIPresentationController`. We can use it in Interface Builder to style the modal view and dimming view. Also configure the presentation and dismissal animations.
open class AnimatableModalViewController: UIViewController, PresentationDesignable {

  // MARK: - AnimatablePresentationController
  public var contextFrameForPresentation: CGRect? {
    didSet {
      presenter?.presentationConfiguration?.contextFrameForPresentation = contextFrameForPresentation
    }
  }

  @IBInspectable var _presentationAnimationType: String? {
    didSet {
      if let animationType = PresentationAnimationType(string: _presentationAnimationType) {
        presentationAnimationType = animationType
      }
    }
  }
  public var presentationAnimationType: PresentationAnimationType = .cover(from: .bottom) {
    didSet {
      if oldValue.stringValue != presentationAnimationType.stringValue {
        configurePresenter()
      }
    }
  }

  @IBInspectable var _dismissalAnimationType: String? {
    didSet {
      if let animationType = PresentationAnimationType(string: _presentationAnimationType) {
        dismissalAnimationType = animationType
      }
    }
  }
  public var dismissalAnimationType: PresentationAnimationType = .cover(from: .bottom) {
    didSet {
      if oldValue.stringValue != dismissalAnimationType.stringValue {
        configurePresenter()
      }
    }
  }

  @IBInspectable public var transitionDuration: Double = .nan {
    didSet {
      presenter?.transitionDuration = transitionDuration
    }
  }
  @IBInspectable var _modalPosition: String? {
    didSet {
      modalPosition = PresentationModalPosition(string: _modalPosition ?? "")
    }
  }

  public var modalPosition: PresentationModalPosition = .center {
    didSet {
      presenter?.presentationConfiguration?.modalPosition = modalPosition
    }
  }
  @IBInspectable var _modalWidth: String? {
    didSet {
      let modalWidth = PresentationModalSize(string: _modalWidth) ?? .half
      modalSize = (modalWidth, modalSize.height)
    }
  }
  @IBInspectable var _modalHeight: String? {
    didSet {
      let modalHeight = PresentationModalSize(string: _modalHeight) ?? .half
      modalSize = (modalSize.width, modalHeight)
    }
  }

  public var modalSize: ModalSize = (.half, .half) {
    didSet {
      presenter?.presentationConfiguration?.modalSize = modalSize
    }
  }

  @IBInspectable public var cornerRadius: CGFloat = .nan {
    didSet {
      presenter?.presentationConfiguration?.cornerRadius = cornerRadius
    }
  }

  @IBInspectable public var dismissOnTap: Bool = true {
    didSet {
      presenter?.presentationConfiguration?.dismissOnTap = dismissOnTap
    }
  }

  @IBInspectable public var backgroundColor: UIColor = .black {
    didSet {
      presenter?.presentationConfiguration?.backgroundColor = backgroundColor
    }
  }

  @IBInspectable public var opacity: CGFloat = 0.7 {
    didSet {
      presenter?.presentationConfiguration?.opacity = opacity
    }
  }

  /// The blur effect style of the dimming view. If use this property, `backgroundColor` and `opacity` are ignored.
  open var blurEffectStyle: UIBlurEffectStyle? {
    didSet {
      presenter?.presentationConfiguration?.blurEffectStyle = blurEffectStyle
    }
  }
  @IBInspectable var _blurEffectStyle: String? {
    didSet {
      blurEffectStyle = UIBlurEffectStyle(string: _blurEffectStyle)
    }
  }

  @IBInspectable public var blurOpacity: CGFloat = .nan {
    didSet {
      presenter?.presentationConfiguration?.blurOpacity = blurOpacity
    }
  }

  @IBInspectable public var shadowColor: UIColor? {
    didSet {
      presenter?.presentationConfiguration?.shadowColor = shadowColor
    }
  }

  @IBInspectable public var shadowRadius: CGFloat = 0.7 {
    didSet {
      presenter?.presentationConfiguration?.shadowRadius = shadowRadius
    }
  }

  @IBInspectable public var shadowOpacity: CGFloat = CGFloat.nan {
    didSet {
      presenter?.presentationConfiguration?.shadowOpacity = shadowOpacity
    }
  }

  @IBInspectable public var shadowOffset: CGPoint = .zero {
    didSet {
      presenter?.presentationConfiguration?.shadowOffset = shadowOffset
    }
  }
  @IBInspectable var _keyboardTranslation: String = "" {
    didSet {
      keyboardTranslation = ModalKeyboardTranslation(string: _keyboardTranslation) ?? .none
    }
  }
  public var keyboardTranslation: ModalKeyboardTranslation = .none {
    didSet {
      presenter?.presentationConfiguration?.keyboardTranslation = keyboardTranslation
    }
  }

  public var presenter: PresentationPresenter?

  // MARK: Life cycle

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    configurePresenter()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configurePresenter()
  }

  // MARK: Life cycle
  override open func viewDidLoad() {
    super.viewDidLoad()
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    configureDismissalTransition()
  }
}
