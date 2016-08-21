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


// Source: https://gist.github.com/TheDarkCode/2f65c1a25d5886ed210c3b33d73fe8a9
// Based on earlier version: http://stackoverflow.com/a/28341290/749786
func iterateEnum<T: Hashable>(from: T.Type) -> AnyIterator<T> {
  var x = 0
  return AnyIterator {
    let next = withUnsafePointer(to: &x) {
      $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
    }
    defer {
      x += 1
    }
    return next.hashValue == x ? next : nil
  }
}
