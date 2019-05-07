//
//  BorderType.swift
//  IBAnimatable
//
//  Created by Tom Baranes on 13/01/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import Foundation

public enum BorderType: IBEnum {
  case solid
  case dash(dashLength: Int, spaceLength: Int)
  case none
}

extension BorderType {

  public init(string: String?) {
    guard let string = string else {
      self = .none
      return
    }

    guard let (name, params) = string.extractNameAndParams() else {
      self = .none
      return
    }
    switch name {
    case "solid":
      self = .solid
    case "dash":
      self = .dash(dashLength: params.toInt(0) ?? 1, spaceLength: params.toInt(1) ?? 1)
    default:
      self = .none
    }
  }
}

extension BorderType: Equatable {
}

public func == (lhs: BorderType, rhs: BorderType) -> Bool {
  switch (lhs, rhs) {
  case (.solid, .solid):
    return true
  case (.dash, .dash):
    return true
  default:
    return false
  }
}
