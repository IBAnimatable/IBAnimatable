//
//  Created by Jake Lin on 12/9/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation

public enum BorderSide: String {
  case Top
  case Right
  case Bottom
  case Left
}

struct BorderSides: OptionSetType {
  let rawValue: Int
  static let None = BorderSides(rawValue: 0)
  static let Top = BorderSides(rawValue: 1)
  static let Right = BorderSides(rawValue: 1 << 1)
  static let Bottom = BorderSides(rawValue: 1 << 2)
  static let Left = BorderSides(rawValue: 1 << 3)
  
  static let AllSides: BorderSides = [.Top, .Right, .Bottom, .Left]
  
  init(rawValue:Int) {
    self.rawValue = rawValue
  }
  
  init(rawValue: String) {
    guard !rawValue.isEmpty else {
      self = .None
      return
    }
    
    let sides = rawValue.characters.split(",").map(String.init).map { BorderSide(rawValue: $0) }.map { BorderSides(side:$0) }
    
    guard !sides.contains(.None) else {
      self = .None
      return
    }
    
    self = BorderSides(sides)
    
  }
  
  init(side: BorderSide?) {
    guard let side = side else { 
      self = .None 
      return 
    }
    
    switch side {
    case .Top: self = .Top
    case .Right: self = .Right
    case .Bottom: self = .Bottom
    case .Left: self = .Left
    }
  }
}