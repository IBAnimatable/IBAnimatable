//
//  CornerSide.swift
//  IBAnimatable
//
//  Created by Miroslav Valkovic-Madjer on 17/11/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation

public enum CornerSide: String {
  case topleft
  case topright
  case bottomleft
  case bottomright
}

public struct CornerSides: OptionSet {
  public let rawValue: Int

  public static let unknown = CornerSides(rawValue: 0)

  public static let topleft = CornerSides(rawValue: 1)
  public static let topright = CornerSides(rawValue: 1 << 1)
  public static let bottomleft = CornerSides(rawValue: 1 << 2)
  public static let bottomright = CornerSides(rawValue: 1 << 3)

  public static let AllSides: CornerSides = [.topleft, .topright, .bottomleft, .bottomright]

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
      .map { CornerSide(rawValue: $0.trimmingCharacters(in: CharacterSet.whitespaces)) }
      .map { CornerSides(side: $0) }

    guard !sideElements.contains(.unknown) else {
      self = .AllSides
      return
    }

    self = CornerSides(sideElements)
  }

  init(side: CornerSide?) {
    guard let side = side else {
      self = .unknown
      return
    }

    switch side {
    case .topleft: self = .topleft
    case .topright: self = .topright
    case .bottomleft: self = .bottomleft
    case .bottomright: self = .bottomright
    }
  }
}
