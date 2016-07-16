//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class AnimatablePresentedViewController: UIViewController, PresentationDesignable {

  // MARK: - PresentationAnimatable

  @IBInspectable public var transitionAnimationType: String?
  @IBInspectable public var transitionDuration: Double = .NaN

  @IBInspectable public var cornerRadius: CGFloat = .NaN {
    didSet {
      presenter?.presentedSetup?.cornerRadius = cornerRadius
    }
  }

  @IBInspectable public var dismissOnTap: Bool = true {
    didSet {
      presenter?.presentedSetup?.dismissOnTap = dismissOnTap
    }
  }

  @IBInspectable public var backgroundColor: UIColor = .blackColor() {
    didSet {
      presenter?.presentedSetup?.backgroundColor = backgroundColor
    }
  }

  @IBInspectable public var opacity: CGFloat = 0.7 {
    didSet {
      presenter?.presentedSetup?.opacity = opacity
    }
  }

  // MARK: Private

  private var presenter: Presenter?

  // MARK: Life cycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  // MARK: Life cycle

  override public func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: Helper

  func commonInit() {
    let animationType = TransitionAnimationType.fromString(transitionAnimationType ?? "") ?? TransitionAnimationType.Fade(direction: .In)
    presenter = PresenterManager.sharedManager().retrievePresenter(animationType, transitionDuration: transitionDuration)
    transitioningDelegate = presenter
    modalPresentationStyle = .Custom

    var presentedSetup = PresentedSetup()
    presentedSetup.cornerRadius = cornerRadius
    presentedSetup.dismissOnTap = dismissOnTap
    presentedSetup.backgroundColor = backgroundColor
    presentedSetup.opacity = opacity
    presenter?.presentedSetup = presentedSetup
  }

}
