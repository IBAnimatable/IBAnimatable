//
//  Created by Tom Baranes on 13/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public enum ModalKeyboardTranslation: String, IBEnum {
  case none
  case moveUp
  case aboveKeyboard
  case stickOrMoveUp

  public func translationFrame(keyboardFrame: CGRect, presentedFrame: CGRect) -> CGRect {
    let keyboardMinY = UIScreen.main.bounds.height - keyboardFrame.height
    var frame = presentedFrame
    switch self {
    case .moveUp:
        frame.origin.y -= keyboardFrame.height
    case .aboveKeyboard:
        frame.origin.y = keyboardMinY - presentedFrame.height - 20
    case .stickOrMoveUp:
      if frame.maxY > keyboardMinY {
        frame.origin.y = keyboardMinY - presentedFrame.height - 20
      }
    default:
        break
    }
    return frame
  }
}

#if swift(>=4.2)
extension ModalKeyboardTranslation: CaseIterable {}
#endif
