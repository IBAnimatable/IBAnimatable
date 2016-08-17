//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/// `AnimatableModalViewController` is a customised modal view controller used as the `presentedViewController` for `UIPresentationController`. We can use it in Interface Builder to style the modal view and dimming view. Also configure the presentation and dismissal animations.
public class AnimatableModalViewController: UIViewController, PresentationDesignable {

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

  @IBInspectable public var transitionDuration: Double = .NaN {
    didSet {
      presenter?.transitionDuration = transitionDuration
    }
  }

  @IBInspectable public var modalPosition: String = "Center" {
    didSet {
      presenter?.presentationConfiguration?.modalPosition = PresentationModalPosition.fromString(modalPosition)
    }
  }

  @IBInspectable public var modalWidth: String = "Half" {
    didSet {
      presenter?.presentationConfiguration?.modalSize = (PresentationModalSize.fromString(modalWidth), PresentationModalSize.fromString(modalHeight))
    }
  }

  @IBInspectable public var modalHeight: String = "Half" {
    didSet {
      presenter?.presentationConfiguration?.modalSize = (PresentationModalSize.fromString(modalWidth), PresentationModalSize.fromString(modalHeight))
    }
  }

  @IBInspectable public var cornerRadius: CGFloat = .NaN {
    didSet {
      presenter?.presentationConfiguration?.cornerRadius = cornerRadius
    }
  }

  @IBInspectable public var dismissOnTap: Bool = true {
    didSet {
      presenter?.presentationConfiguration?.dismissOnTap = dismissOnTap
    }
  }

  @IBInspectable public var backgroundColor: UIColor = .blackColor() {
    didSet {
      presenter?.presentationConfiguration?.backgroundColor = backgroundColor
    }
  }

  @IBInspectable public var opacity: CGFloat = 0.7 {
    didSet {
      presenter?.presentationConfiguration?.opacity = opacity
    }
  }

  @IBInspectable public var blurEffectStyle: String? {
    didSet {
      presenter?.presentationConfiguration?.blurEffectStyle = blurEffectStyle
    }
  }

  @IBInspectable public var blurOpacity: CGFloat = .NaN {
    didSet {
      presenter?.presentationConfiguration?.blurOpacity = blurOpacity
    }
  }

  @IBInspectable public var shadowColor: UIColor? {
    didSet {
      presenter?.presentationConfiguration?.shadowColor = shadowColor
    }
  }

  @IBInspectable public var shadowRadius: CGFloat = CGFloat.NaN {
    didSet {
      presenter?.presentationConfiguration?.shadowRadius = shadowRadius
    }
  }

  @IBInspectable public var shadowOpacity: CGFloat = CGFloat.NaN {
    didSet {
      presenter?.presentationConfiguration?.shadowOpacity = shadowOpacity
    }
  }

  @IBInspectable public var shadowOffset: CGPoint = CGPoint(x: CGFloat.NaN, y: CGFloat.NaN) {
    didSet {
      presenter?.presentationConfiguration?.shadowOffset = shadowOffset
    }
  }

  @IBInspectable public var keyboardTranslation: String? {
    didSet {
      presenter?.presentationConfiguration?.keyboardTranslation = ModalKeyboardTranslation.fromString(keyboardTranslation)
    }
  }

  // MARK: Private

  private var presenter: PresentationPresenter?

  // MARK: Life cycle

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setupPresenter()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupPresenter()
  }

  // MARK: Life cycle

  override public func viewDidLoad() {
    super.viewDidLoad()
  }

  public override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    let animationType = PresentationAnimationType.fromString(dismissalAnimationType ?? "") ?? .Cover(fromDirection: .Bottom)
    if let dismissSystemTransition = animationType.systemTransition {
      modalTransitionStyle = dismissSystemTransition
    }
  }
}

private extension AnimatableModalViewController {
  func setupPresenter() {
    // If not set, use the system default transition `.CoverVertical` which maps to `.Cover(fromDirection: .Bottom)`
    let animationType = PresentationAnimationType.fromString(presentationAnimationType ?? "") ?? .Cover(fromDirection: .Bottom)
    presenter = PresentationPresenterManager.sharedManager().retrievePresenter(animationType, transitionDuration: transitionDuration)
    presenter?.dismissalAnimationType = PresentationAnimationType.fromString(dismissalAnimationType ?? "")
    transitioningDelegate = presenter
    modalPresentationStyle = .Custom
    if let systemTransition = animationType.systemTransition {
      modalTransitionStyle = systemTransition
    }
    
    var presentationConfiguration = PresentationConfiguration()
    presentationConfiguration.modalPosition = PresentationModalPosition.fromString(modalPosition)
    presentationConfiguration.modalSize = (PresentationModalSize.fromString(modalWidth), PresentationModalSize.fromString(modalHeight))
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
    presentationConfiguration.keyboardTranslation = ModalKeyboardTranslation.fromString(keyboardTranslation)
    presenter?.presentationConfiguration = presentationConfiguration
  }
}
