//
//  Created by jason akakpo on 27/06/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation

/**
 A protocol provides extension method for converting `String` into `enum`.
 Because `@IBInspectable` property can not support `enum` directly. To provide both `enum` API in code and `@IBInspectable` supported type `String` in Interface Builder, we use `IBEnum` to bridge Swift `enum` and `String`
 */
public protocol IBEnum {
  /**
   Initializes a swift `enum` with provided optional string

   - Parameter string: The optional string to be converted into `enum`.
   */
  init?(string: String?)
}

extension IBEnum {
  init(string: String?, default defaultValue: Self) {
    self = Self(string: string) ?? defaultValue
  }
}

/// IBEnum provide default initializer for RawRepresentable Enum
#if swift(>=4.2)
public extension IBEnum where Self: RawRepresentable & CaseIterable {
  init?(string: String?) {
    if let item = getCase(for: string, from: iterateEnum(from: Self.self)) {
      self = item
    } else {
      return nil
    }
  }
}
#else
public extension IBEnum where Self: RawRepresentable & Hashable {
  init?(string: String?) {
    if let item = getCase(for: string, from: iterateEnum(from: Self.self)) {
      self = item
    } else {
      return nil
    }
  }
}
#endif

private func getCase<T: IBEnum & RawRepresentable>(for string: String?, from iterator: AnyIterator<T>) -> T? {
  let lowerString = string?.lowercased()
  for item in iterator {
    if String(describing: item.rawValue).lowercased() == lowerString {
      return item
    }
  }
  return nil
}
