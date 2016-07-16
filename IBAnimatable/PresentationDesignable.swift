//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public protocol PresentationDesignable: class {

  var transitionAnimationType: String? { get set }
  var transitionDuration: Double { get set }

  var roundCorners: Bool { get set }
  var dismissOnTap: Bool { get set }
  var backgroundColor: UIColor { get set }
  var backgroundOpacity: Float { get set }

}

public struct PresentedSetup {
  var roundCorners: Bool = true
  var dismissOnTap: Bool = true
  var backgroundColor: UIColor = .blackColor()
  var backgroundOpacity: Float = 0.7
}
