//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public protocol PresentationDesignable: class {

  var presentationAnimationType: String? { get set }
  var dismissAnimationType: String? { get set }
  var transitionDuration: Double { get set }

  var cornerRadius: CGFloat { get set }
  var dismissOnTap: Bool { get set }

  var backgroundColor: UIColor { get set }
  var opacity: CGFloat { get set }

  var blurEffectStyle: String? { get set }
  var blurOpacity: CGFloat { get set }

  var shadowColor: UIColor? { get set }
  var shadowRadius: CGFloat { get set }
  var shadowOpacity: CGFloat { get set }
  var shadowOffset: CGPoint { get set }
}

public struct PresentedSetup {
  var cornerRadius: CGFloat = .NaN
  var dismissOnTap: Bool = true
  var backgroundColor: UIColor = .blackColor()
  var opacity: CGFloat = 0.7
  var blurEffectStyle: String?
  var blurOpacity: CGFloat = .NaN
  var shadowColor: UIColor?
  var shadowRadius: CGFloat = .NaN
  var shadowOpacity: CGFloat = .NaN
  var shadowOffset: CGPoint = CGPoint(x: CGFloat.NaN, y: CGFloat.NaN)
}
