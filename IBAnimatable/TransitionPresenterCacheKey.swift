//
//  TransitionPresenterChacheKey.swift
//  IBAnimatable
//
//  Created by Miro on 8/12/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation

struct TransitionPresenterChacheKey: Hashable {
  
  var transitionAnimationType: TransitionAnimationType
  
  var hashValue: Int {
    return transitionAnimationType.stringValue.hashValue
  }
  
  static func == (lhs: TransitionPresenterChacheKey, rhs: TransitionPresenterChacheKey) -> Bool {
    return lhs.transitionAnimationType.stringValue == rhs.transitionAnimationType.stringValue
  }
}
