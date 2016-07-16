//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public class AnimatablePresentedViewController: UIViewController, PresentationDesignable {

  // MARK: - TransitionAnimatable
  @IBInspectable public var transitionAnimationType: String?
  @IBInspectable public var transitionDuration: Double = .NaN

  @IBInspectable public var cornerRadius: CGFloat = .NaN
  @IBInspectable public var dismissOnTap: Bool = true
  @IBInspectable public var backgroundColor: UIColor = .blackColor()
  @IBInspectable public var opacity: CGFloat = 0.7

  // MARK: Life cycle

  override public func viewDidLoad() {
    super.viewDidLoad()
  }
  
}
