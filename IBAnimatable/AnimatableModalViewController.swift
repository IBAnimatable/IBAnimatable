//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/// `AnimatableModalViewController` is a customised modal view controller used as the `presentedViewController` for `UIPresentationController`. We can use it in Interface Builder to style the modal view and dimming view. Also configure the presentation and dismissal animations.
open class AnimatableModalViewController: UIViewController, PresentationDesignable {

  // MARK: - AnimatablePresentationController

  @IBInspectable public var presentationAnimationType: String? {
    didSet {
      if oldValue != presentationAnimationType {
        setupPresenter()
      }
    }
  }

  @IBInspectable public var dismissalAnimationType: String? {
    didSet {
      if oldValue != dismissalAnimationType {
        setupPresenter()
      }
    }
  }

  @IBInspectable public var transitionDuration: Double = .nan {
    didSet {
      presenter?.transitionDuration = transitionDuration
    }
  }

  @IBInspectable public var modalPosition: String = "Center" {
    didSet {
      presenter?.presentationConfiguration?.modalPosition = PresentationModalPosition.fromString(position: modalPosition)
    }
  }

  @IBInspectable public var modalWidth: String = "Half" {
    didSet {
      presenter?.presentationConfiguration?.modalSize = (PresentationModalSize.fromString(size: modalWidth), PresentationModalSize.fromString(size: modalHeight))
    }
  }

  @IBInspectable public var modalHeight: String = "Half" {
    didSet {
      presenter?.presentationConfiguration?.modalSize = (PresentationModalSize.fromString(size: modalWidth), PresentationModalSize.fromString(size: modalHeight))
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

  @IBInspectable public var keyboardTranslation: String? {
    didSet {
      presenter?.presentationConfiguration?.keyboardTranslation = ModalKeyboardTranslation.fromString(string: keyboardTranslation)
    }
  }

  // MARK: Private

  fileprivate var presenter: PresentationPresenter?

  // MARK: Life cycle

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setupPresenter()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupPresenter()
  }

  // MARK: Life cycle

  override open func viewDidLoad() {
    super.viewDidLoad()
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let animationType = PresentationAnimationType.fromString(transitionType: dismissalAnimationType ?? "") ?? .cover(fromDirection: .bottom)
    if let dismissSystemTransition = animationType.systemTransition {
      modalTransitionStyle = dismissSystemTransition
    }
  }
}

private extension AnimatableModalViewController {
  func setupPresenter() {
    // If not set, use the system default transition `.CoverVertical` which maps to `.Cover(fromDirection: .Bottom)`
    let animationType = PresentationAnimationType.fromString(transitionType: presentationAnimationType ?? "") ?? .cover(fromDirection: .bottom)
    presenter = PresentationPresenterManager.sharedManager().retrievePresenter(presentationAnimationType: animationType, transitionDuration: transitionDuration)
    presenter?.dismissalAnimationType = PresentationAnimationType.fromString(transitionType: dismissalAnimationType ?? "")
    transitioningDelegate = presenter
    modalPresentationStyle = .custom
    if let systemTransition = animationType.systemTransition {
      modalTransitionStyle = systemTransition
    }
    
    var presentationConfiguration = PresentationConfiguration()
    presentationConfiguration.modalPosition = PresentationModalPosition.fromString(position: modalPosition)
    presentationConfiguration.modalSize = (PresentationModalSize.fromString(size: modalWidth), PresentationModalSize.fromString(size: modalHeight))
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
    presentationConfiguration.keyboardTranslation = ModalKeyboardTranslation.fromString(string: keyboardTranslation)
    presenter?.presentationConfiguration = presentationConfiguration
  }
}
