//
//  Created by Jake Lin on 12/9/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import Foundation

public enum BorderSide: String {
  case top
  case right
  case bottom
  case left
}

public struct BorderSides: OptionSet {
  public let rawValue: Int

  public static let unknown = BorderSides(rawValue: 0)

  public static let top = BorderSides(rawValue: 1)
  public static let right = BorderSides(rawValue: 1 << 1)
  public static let bottom = BorderSides(rawValue: 1 << 2)
  public static let left = BorderSides(rawValue: 1 << 3)

  public static let AllSides: BorderSides = [.top, .right, .bottom, .left]

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

  init(rawValue: String?) {
    guard let rawValue = rawValue, !rawValue.isEmpty else {
      self = .AllSides
      return
    }
    let sideElements = rawValue.lowercased().characters.split(separator: ",")
      .map(String.init)
      .map { BorderSide(rawValue: $0.trimmingCharacters(in: CharacterSet.whitespaces)) }
      .map { BorderSides(side: $0) }

    guard !sideElements.contains(.unknown) else {
      self = .AllSides
      return
    }

    self = BorderSides(sideElements)

  }

  init(side: BorderSide?) {
    guard let side = side else {
      self = .unknown
      return
    }

    switch side {
    case .top: self = .top
    case .right: self = .right
    case .bottom: self = .bottom
    case .left: self = .left
    }
  }
}
