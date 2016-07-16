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
      presentedSetup.cornerRadius = cornerRadius
    }
  }

  @IBInspectable public var dismissOnTap: Bool = true {
    didSet {
      presentedSetup.dismissOnTap = dismissOnTap
    }
  }

  @IBInspectable public var backgroundColor: UIColor = .blackColor() {
    didSet {
      presentedSetup.backgroundColor = backgroundColor
    }
  }

  @IBInspectable public var opacity: CGFloat = 0.7 {
    didSet {
      presentedSetup.opacity = opacity
    }
  }

  // MARK: Private
  private var presentedSetup = PresentedSetup()

  // MARK: Life cycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  func commonInit() {
    presentedSetup.cornerRadius = cornerRadius
    presentedSetup.dismissOnTap = dismissOnTap
    presentedSetup.backgroundColor = backgroundColor
    presentedSetup.opacity = opacity

    let animationType = TransitionAnimationType.fromString(transitionAnimationType ?? "") ?? TransitionAnimationType.Fade(direction: .In)
    transitioningDelegate = PresenterManager.sharedManager().retrievePresenter(animationType, transitionDuration: transitionDuration, presentedSetup: presentedSetup)
    modalPresentationStyle = .Custom
  }

  // MARK: Life cycle

  override public func viewDidLoad() {
    super.viewDidLoad()
  }

}
