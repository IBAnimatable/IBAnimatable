//
//  Created by Tom Baranes on 16/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public typealias ModalSize = (width: PresentationModalSize, height: PresentationModalSize)
/// PresentationDesignable is a protocol to define customised modal view controller which is used as the `presentedViewController` for `UIPresentationController` 
public protocol PresentationDesignable: class {

  /// Presentation animation type, all supported animation type can be found in `PresentationAnimationType`
  var presentationAnimationType: PresentationAnimationType { get set }
  
  /// Dismissal animation type, all supported animation type can be found in `PresentationAnimationType`
  var dismissalAnimationType: PresentationAnimationType { get set }
  /// Tranistion duration
  var transitionDuration: Double { get set }
  
  
  // Modal position, all supported modal position can be found in `PresentationModalPosition`
  var modalPosition: PresentationModalPosition { get set }
  
  // Modal Size, all supported modal Sizes can be found in `PresentationModalSize`
  var modalSize: ModalSize { get set }
  
  
  /// The corner radius of the modal view
  var cornerRadius: CGFloat { get set }
  

  /// If set to `true`, the modal view will dismiss when tap on the dimming view.
  var dismissOnTap: Bool { get set }

  
  /// The background color of the dimming view. The default value is black color.
  var backgroundColor: UIColor { get set }
  
  /// The opacity of the dimming view. The default value is `0.7`.
  var opacity: CGFloat { get set }

  
  /// The blur effect style of the dimming view. If use this property, `backgroundColor` and `opacity` are ignored.
  var blurEffectStyle: UIBlurEffectStyle? { get set }
  
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
  var keyboardTranslation: ModalKeyboardTranslation { get set }

}

/// `PresentationConfiguration` a struct is used for specifying the dimming view and modal view for `AnimatablePresentationController`
public struct PresentationConfiguration {
  var cornerRadius: CGFloat = .nan
  var dismissOnTap: Bool = true
  var backgroundColor: UIColor = .black
  var opacity: CGFloat = 0.7
  var blurEffectStyle: UIBlurEffectStyle?
  var blurOpacity: CGFloat = .nan
  var shadowColor: UIColor?
  var shadowRadius: CGFloat = .nan
  var shadowOpacity: CGFloat = 0.7
  var shadowOffset: CGPoint = .zero
  var modalPosition: PresentationModalPosition = .center
  var modalSize: (PresentationModalSize, PresentationModalSize) = (.half, .half)
  var keyboardTranslation = ModalKeyboardTranslation.none
}
