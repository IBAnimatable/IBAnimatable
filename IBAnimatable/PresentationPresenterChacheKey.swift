//
//  PresentationChacheKey.swift
//  IBAnimatable
//
//  Created by Miro on 8/12/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation

struct PresentationPresenterChacheKey: Hashable {
  
  var presentationAnimationType: PresentationAnimationType
  
  var hashValue: Int {
    return presentationAnimationType.stringValue.hashValue
  }
  
  static func == (lhs: PresentationPresenterChacheKey, rhs: PresentationPresenterChacheKey) -> Bool {
    return lhs.presentationAnimationType.stringValue == rhs.presentationAnimationType.stringValue
  }
}
