//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class AnimatableModalViewController: UIViewController, PresentationDesignable {

  // MARK: - AnimatablePresentationController

  @IBInspectable public var presentationAnimationType: String? {
    didSet {
      setupPresenter()
    }
  }

  @IBInspectable public var dismissalAnimationType: String? {
    didSet {
      setupPresenter()
    }
  }

  @IBInspectable public var transitionDuration: Double = .NaN {
    didSet {
      presenter?.transitionDuration = transitionDuration
    }
  }

  @IBInspectable public var modalPosition: String = "Center" {
    didSet {
      presenter?.presentionConfiguration?.modalPosition = PresentationModalPosition.fromString(modalPosition)
    }
  }

  @IBInspectable public var modalWidth: String = "Half" {
    didSet {
      presenter?.presentionConfiguration?.modalSize = (PresentationModalSize.fromString(modalWidth), PresentationModalSize.fromString(modalHeight))
    }
  }

  @IBInspectable public var modalHeight: String = "Half" {
    didSet {
      presenter?.presentionConfiguration?.modalSize = (PresentationModalSize.fromString(modalWidth), PresentationModalSize.fromString(modalHeight))
    }
  }

  @IBInspectable public var cornerRadius: CGFloat = .NaN {
    didSet {
      presenter?.presentionConfiguration?.cornerRadius = cornerRadius
    }
  }

  @IBInspectable public var dismissOnTap: Bool = true {
    didSet {
      presenter?.presentionConfiguration?.dismissOnTap = dismissOnTap
    }
  }

  @IBInspectable public var backgroundColor: UIColor = .blackColor() {
    didSet {
      presenter?.presentionConfiguration?.backgroundColor = backgroundColor
    }
  }

  @IBInspectable public var opacity: CGFloat = 0.7 {
    didSet {
      presenter?.presentionConfiguration?.opacity = opacity
    }
  }

  @IBInspectable public var blurEffectStyle: String? {
    didSet {
      presenter?.presentionConfiguration?.blurEffectStyle = blurEffectStyle
    }
  }

  @IBInspectable public var blurOpacity: CGFloat = .NaN {
    didSet {
      presenter?.presentionConfiguration?.blurOpacity = blurOpacity
    }
  }

  @IBInspectable public var shadowColor: UIColor? {
    didSet {
      presenter?.presentionConfiguration?.shadowColor = shadowColor
    }
  }

  @IBInspectable public var shadowRadius: CGFloat = CGFloat.NaN {
    didSet {
      presenter?.presentionConfiguration?.shadowRadius = shadowRadius
    }
  }

  @IBInspectable public var shadowOpacity: CGFloat = CGFloat.NaN {
    didSet {
      presenter?.presentionConfiguration?.shadowOpacity = shadowOpacity
    }
  }

  @IBInspectable public var shadowOffset: CGPoint = CGPoint(x: CGFloat.NaN, y: CGFloat.NaN) {
    didSet {
      presenter?.presentionConfiguration?.shadowOffset = shadowOffset
    }
  }

  // MARK: Private

  private var presenter: PresentationPresenter?

  // MARK: Life cycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
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
    let animationType = PresentationAnimationType.fromString(dismissalAnimationType ?? "") ?? PresentationAnimationType.Cover(fromDirection: .Bottom)
    if let dismissSystemTransition = animationType.systemTransition {
      modalTransitionStyle = dismissSystemTransition
    }
  }

  // MARK: Helper

  func setupPresenter() {
    let animationType = PresentationAnimationType.fromString(presentationAnimationType ?? "") ?? PresentationAnimationType.Cover(fromDirection: .Bottom)
    presenter = PresentationPresenterManager.sharedManager().retrievePresenter(animationType, transitionDuration: transitionDuration)
    presenter?.dismissalAnimationType = PresentationAnimationType.fromString(dismissalAnimationType ?? "")
    transitioningDelegate = presenter
    modalPresentationStyle = .Custom
    if let systemTransition = animationType.systemTransition {
      modalTransitionStyle = systemTransition
    }

    var presentionConfiguration = PresentionConfiguration()
    presentionConfiguration.modalPosition = PresentationModalPosition.fromString(modalPosition)
    presentionConfiguration.modalSize = (PresentationModalSize.fromString(modalWidth), PresentationModalSize.fromString(modalHeight))
    presentionConfiguration.cornerRadius = cornerRadius
    presentionConfiguration.dismissOnTap = dismissOnTap
    presentionConfiguration.backgroundColor = backgroundColor
    presentionConfiguration.opacity = opacity
    presentionConfiguration.blurEffectStyle = blurEffectStyle
    presentionConfiguration.blurOpacity = blurOpacity
    presentionConfiguration.shadowColor = shadowColor
    presentionConfiguration.shadowOpacity = shadowOpacity
    presentionConfiguration.shadowRadius = shadowRadius
    presentionConfiguration.shadowOffset = shadowOffset
    presenter?.presentionConfiguration = presentionConfiguration
  }

}
