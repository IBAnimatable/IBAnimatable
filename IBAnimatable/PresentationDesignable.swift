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

}

public struct PresentedSetup {
  var cornerRadius: CGFloat = CGFloat.NaN
  var dismissOnTap: Bool = true
  var backgroundColor: UIColor = .blackColor()
  var opacity: CGFloat = 0.7
}
