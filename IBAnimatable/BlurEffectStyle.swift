//
//  Created by Jake Lin on 12/5/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit


extension UIBlurEffectStyle : IBOptionalEnum {
  /** initialize a UIBlurEffectStyle from string. `extraLight`, `light`, `dark`, `prominent` (iOS 10+), `extraLight` (iOS 10+)
    default value is `extraLight`.
   defaultValue is used when the string is nil or not within the above list
  */
  public init?(string: String?) {
    guard let string = string?.lowercased() else {
      return nil
    }
    
    switch string {
    case "extralight":
      self = .extraLight
      return
    case "light":
      self = .light
      return
    case "dark":
      self = .dark
      return
    case "prominent":
      if #available(iOSApplicationExtension 10.0, *) {
        self = .prominent
        return
      }
    case "regular":
      if #available(iOSApplicationExtension 10.0, *) {
        self = .regular
        return
      }
    default: break
    }
    return nil
  }
}
