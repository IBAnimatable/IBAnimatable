//
//  CornerSide.swift
//  IBAnimatable
//
//  Created by Miroslav Valkovic-Madjer on 17/11/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation

public enum CornerSide: String {
  case topLeft = "topleft"
  case topRight = "topright"
  case bottomLeft = "bottomleft"
  case bottomRight = "bottomright"
}

public struct CornerSides: OptionSet {
  public let rawValue: Int

  public static let unknown = CornerSides(rawValue: 0)

  public static let topLeft = CornerSides(rawValue: 1)
  public static let topRight = CornerSides(rawValue: 1 << 1)
  public static let bottomLeft = CornerSides(rawValue: 1 << 2)
  public static let bottomRight = CornerSides(rawValue: 1 << 3)

  public static let allSides: CornerSides = [.topLeft, .topRight, .bottomLeft, .bottomRight]

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }

  init(rawValue: String?) {
    guard let rawValue = rawValue, !rawValue.isEmpty else {
      self = .allSides
      return
    }

    let sideElements = rawValue.lowercased().characters.split(separator: ",")
      .map(String.init)
      .map { CornerSide(rawValue: $0.trimmingCharacters(in: CharacterSet.whitespaces)) }
      .map { CornerSides(side: $0) }

    guard !sideElements.contains(.unknown) else {
      self = .allSides
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
    case .topLeft: self = .topLeft
    case .topRight: self = .topRight
    case .bottomLeft: self = .bottomLeft
    case .bottomRight: self = .bottomRight
    }
  }
}
