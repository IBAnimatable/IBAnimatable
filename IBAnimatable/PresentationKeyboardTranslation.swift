//
//  Created by Tom Baranes on 13/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public enum ModalKeyboardTranslation {
  case None
  case MoveUp  
  case AboveKeyboard

  static public func fromString(string: String?) -> ModalKeyboardTranslation {
    if string == "MoveUp" {
      return .MoveUp
    } else if string == "AboveKeyboard" {
      return .AboveKeyboard
    }
    return .None
  }

  public func translationFrame(keyboardFrame: CGRect, presentedFrame: CGRect) -> CGRect {
    let keyboardMinY = UIScreen.mainScreen().bounds.height - keyboardFrame.height
    let presentedViewMaxY = presentedFrame.origin.y + presentedFrame.height + 20.0
    let offset = presentedViewMaxY - keyboardMinY
    var frame = presentedFrame
    switch self {
    case .MoveUp: frame.origin.y -= keyboardFrame.height; break
    case .AboveKeyboard: frame.origin.y = keyboardMinY - presentedFrame.height - 20
    default: break
    }
    return frame
  }
}
