//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

/// PresentationDesignable is a protocol to define customised modal view controller which is used as the `presentedViewController` for `UIPresentationController` 
public protocol PresentationDesignable: class {

  /// Presentation animation type, all supported animation type can be found in `PresentationAnimationType`
  var presentationAnimationType: String? { get set }
  
  /// Dismissal animation type, all supported animation type can be found in `PresentationAnimationType`
  var dismissalAnimationType: String? { get set }
  /// Tranistion duration
  var transitionDuration: Double { get set }
  
  
  // Modal position, all supported modal position can be found in `PresentationModalPosition`
  var modalPosition: String { get set }
  
  // Modal width, all supported modal width can be found in `PresentationModalSize`
  var modalWidth: String { get set }
  
  // Modal height, all supported modal width can be found in `PresentationModalSize`
  var modalHeight: String { get set }

  
  /// The corner radius of the modal view
  var cornerRadius: CGFloat { get set }
  

  /// If set to `true`, the modal view will dismiss when tap on the dimming view.
  var dismissOnTap: Bool { get set }

  
  /// The background color of the dimming view. The default value is black color.
  var backgroundColor: UIColor { get set }
  
  /// The opacity of the dimming view. The default value is `0.7`.
  var opacity: CGFloat { get set }

  
  /// The blur effect style of the dimming view. If use this property, `backgroundColor` and `opacity` are ignored.
  var blurEffectStyle: String? { get set }
  
  /// The blur opacity of the dimming view. If use this property, `backgroundColor` and `opacity` are ignored.
  var blurOpacity: CGFloat { get set }

 
  /// The shadow color of the modal view. If use this property, `cornerRadius` is ignored.
  var shadowColor: UIColor? { get set }
  
  /// The shadow radius of the modal view. If use this property, `cornerRadius` is ignored.
  var shadowRadius: CGFloat { get set }
  
  /// The shadow opacity of the modal view. If use this property, `cornerRadius` is ignored.
  var shadowOpacity: CGFloat { get set }
  
  /// The shadow offset of the modal view. If use this property, `cornerRadius` is ignored.
  var shadowOffset: CGPoint { get set }

  /// Modal's translation when the keyboard is opening
  var keyboardTranslation: String? { get set }

}

/// `PresentationConfiguration` a struct is used for specifying the dimming view and modal view for `AnimatablePresentationController`
public struct PresentationConfiguration {
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
  var modalPosition: PresentationModalPosition = .Center
  var modalSize: (PresentationModalSize, PresentationModalSize) = (.Half, .Half)
  var keyboardTranslation = ModalKeyboardTranslation.None
}
