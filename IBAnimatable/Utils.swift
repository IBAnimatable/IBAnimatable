//
//  Utils.swift
//  IBAnimatableApp
//
//  Created by jason akakpo on 03/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

extension Array {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript(safe index: Int ) -> Element? {
    return indices.contains(index) ? self[index] : nil  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  }
}

extension String {
  func toDouble() -> Double? {
    return Double(self)
  }
  func toInt() -> Int? {
    return Int(self)
  }
}

internal extension RawRepresentable {
  
  init?(raw: RawValue?) {
    guard let raw = raw else {
      return nil
    }
    self.init(rawValue: raw)
  }

  init(raw: RawValue?, defaultValue: Self) {
    guard let value = raw  else {
      self = defaultValue
      return
    }
    self = Self.init(rawValue: value) ?? defaultValue
  }
}
