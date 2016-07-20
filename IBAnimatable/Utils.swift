//
//  Utils.swift
//  IBAnimatableApp
//
//  Created by jason akakpo on 03/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

internal extension Array {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript(safe index: Int ) -> Element? {
    return indices.contains(index) ? self[index] : nil  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  }
}

internal extension String {
  func toDouble() -> Double? {
    return Double(self)
  }
  func toInt() -> Int? {
    return Int(self)
  }
}

internal extension RawRepresentable where RawValue == String {
  init?(raw: String?) {
    guard let string = raw else {
      return nil
    }
    self.init(rawValue: string)
  }
}
internal extension RawRepresentable {
  init(raw: RawValue?,  defaultValue: Self) {
    if let value = raw  {
      self = Self.init(rawValue: value) ?? defaultValue
    }
    self = defaultValue
  }
}
