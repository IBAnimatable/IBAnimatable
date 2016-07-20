//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import Foundation
import UIKit

/**
 Predefined Animation Type
 */
public enum AnimationType {
  case slide(way: Way, direction: Direction)
  case squeeze(way: Way, direction: Direction) // miss squeeze
  case slideFade(way: Way, direction: Direction)
  case fade(way: FadeWay)
  case squeezeFade(way: Way, direction: Direction)
  case zoom(way: Way)
  case shake
  case pop
  case flip(along: Axis)
  case morph
  case flash
  case wobble
  case swing
  case rotate(direction: RotationDirection)
  case moveTo(x: Double, y: Double)
  case moveBy(x: Double, y: Double)
  case none
  
  public enum FadeWay: String {
    case `in`, out, inOut = "inout", outIn = "outin"
  }
  public enum Way: String {
    case out, `in`
  }
  public enum Axis: String {
    case x, y
  }
  public enum Direction: String {
    case left, right, up, down
    
    func isVertical() -> Bool {
      return self == .down || self == .up
    }
  }
  public enum RotationDirection: String {
    case cw, ccw
  }
}

extension AnimationType : IBEnum {
  
  public init(string: String?) {
    guard let string = string else {
      self = .none
      return
    }
    let nameAndParames = MaskType.extractNameAndParams(from: string.lowercased())
    let name = nameAndParames.name
    let params = nameAndParames.params
    
    switch name {
    case "slide":
      self = .slide(way: Way(raw: params[safe: 0], defaultValue: .in), direction: Direction(raw: params[safe: 1], defaultValue: .left))
    case "squeeze":
      self = .squeeze(way: Way(raw: params[safe: 0], defaultValue: .in), direction: Direction(raw: params[safe: 1], defaultValue: .left))
    case "fade":
      self = .fade(way: FadeWay(raw: params[safe: 0], defaultValue: .in))
    case "slidefade":
      self = .slideFade(way: Way(raw: params[safe: 0], defaultValue: .in), direction: Direction(raw: params[safe: 1], defaultValue: .left))
    case "squeezefade":
      self = .squeezeFade(way: Way(raw: params[safe: 0], defaultValue: .in), direction: Direction(raw: params[safe: 1], defaultValue: .left))
    case "zoom":
      self = .zoom(way: Way(raw: params[safe: 0], defaultValue: .in))
    case "shake":
      self = .shake
    case "pop":
      self = .pop
    case "flip":
      self = .flip(along: Axis(raw: params[safe: 0], defaultValue: .x))
    case "morph":
      self = .morph
    case "flash":
      self = .flash
    case "wobble":
      self = .wobble
    case "swing":
      self = .swing
    case "rotate":
      self = .rotate(direction: RotationDirection(raw: params[safe: 0], defaultValue: .cw))
    case "moveto":
      self = .moveTo(x: params[safe: 0]?.toDouble() ?? 0, y: params[safe: 1]?.toDouble() ?? 0)
    case "moveby":
      self = .moveBy(x: params[safe: 0]?.toDouble() ?? 0, y: params[safe: 1]?.toDouble() ?? 0)
    default:
      self = .none
    }
  }
}
