//
//  Created by Jake Lin on 11/19/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

/**
 Predefined Animation Type
 */

public indirect enum AnimationType {
  case slide(way: Way, direction: Direction)
  case squeeze(way: Way, direction: Direction)
  case slideFade(way: Way, direction: Direction)
  case squeezeFade(way: Way, direction: Direction)
  case fade(way: FadeWay)
  case zoom(way: Way)
  case zoomInvert(way: Way)
  case shake(repeatCount: Int)
  case pop(repeatCount: Int)
  case squash(repeatCount: Int)
  case flip(along: Axis)
  case morph(repeatCount: Int)
  case flash(repeatCount: Int)
  case wobble(repeatCount: Int)
  case swing(repeatCount: Int)
  case rotate(direction: RotationDirection, repeatCount: Int)
  case moveTo(x: Double, y: Double)
  case moveBy(x: Double, y: Double)
  case scale(fromX: Double, fromY: Double, toX: Double, toY: Double)
  case spin(repeatCount: Int)
  case compound(animations: [AnimationType], run: Run)
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
  public enum Run: String {
    case sequential, parallel
  }

}

#if swift(>=4.2)
extension AnimationType.Axis: CaseIterable {}
extension AnimationType.Direction: CaseIterable {}
extension AnimationType.FadeWay: CaseIterable {}
extension AnimationType.RotationDirection: CaseIterable {}
extension AnimationType.Run: CaseIterable {}
extension AnimationType.Way: CaseIterable {}
#endif

extension AnimationType {

  public static func scaleTo(x: Double, y: Double) -> AnimationType {
    return .scale(fromX: 1, fromY: 1, toX: x, toY: y)
  }

  public static func scaleFrom(x: Double, y: Double) -> AnimationType {
    return .scale(fromX: x, fromY: y, toX: 1, toY: 1)
  }

}

extension AnimationType: IBEnum {

  public init(string: String?) {
    guard let string = string else {
      self = .none
      return
    }

    let nodes = string.parseNameAndParams()
    guard let firstNode = nodes.first else {
      self = .none
      return
    }
    self.init(node: firstNode)
  }

  init(node: Udra.Node) {
    let params: [Udra.Node] = (node as? Udra.ParentNode)?.children ?? []
    switch node.name {
    case "slide":
      self = .slide(way: Way(raw: params.toString(0), defaultValue: .in), direction: Direction(raw: params.toString(1), defaultValue: .left))
    case "squeeze":
      self = .squeeze(way: Way(raw: params.toString(0), defaultValue: .in), direction: Direction(raw: params.toString(1), defaultValue: .left))
    case "fade":
      self = .fade(way: FadeWay(raw: params.toString(0), defaultValue: .in))
    case "slidefade":
      self = .slideFade(way: Way(raw: params.toString(0), defaultValue: .in), direction: Direction(raw: params.toString(1), defaultValue: .left))
    case "squeezefade":
      self = .squeezeFade(way: Way(raw: params.toString(0), defaultValue: .in), direction: Direction(raw: params.toString(1), defaultValue: .left))
    case "zoom":
      self = .zoom(way: Way(raw: params.toString(0), defaultValue: .in))
    case "zoominvert":
      self = .zoomInvert(way: Way(raw: params.toString(0), defaultValue: .in))
    case "shake":
      self = .shake(repeatCount: params.toInt(0) ?? 1)
    case "pop":
      self = .pop(repeatCount: params.toInt(0) ?? 1)
    case "squash":
      self = .squash(repeatCount: params.toInt(0) ?? 1)
    case "flip":
      let axis = Axis(raw: params.toString(0), defaultValue: .x)
      self = .flip(along: axis)
    case "morph":
      self = .morph(repeatCount: params.toInt(0) ?? 1)
    case "flash":
      self = .flash(repeatCount: params.toInt(0) ?? 1)
    case "wobble":
      self = .wobble(repeatCount: params.toInt(0) ?? 1)
    case "swing":
      self = .swing(repeatCount: params.toInt(0) ?? 1)
    case "rotate":
      self = .rotate(direction: RotationDirection(raw: params.toString(0), defaultValue: .cw), repeatCount: params.toInt(1) ?? 1)
    case "moveto":
      self = .moveTo(x: params.toDouble(0) ?? 0, y: params.toDouble(1) ?? 0)
    case "moveby":
      self = .moveBy(x: params.toDouble(0) ?? 0, y: params.toDouble(1) ?? 0)
    case "scale":
      let fromX = params.toDouble(0) ?? 0
      let fromY = params.toDouble(1) ?? 0
      let toX = params.toDouble(2) ?? 1
      let toY = params.toDouble(3) ?? 1
      self = .scale(fromX: fromX, fromY: fromY, toX: toX, toY: toY)
    case "scalefrom":
      self = .scaleFrom(x: params.toDouble(0) ?? 0, y: params.toDouble(1) ?? 0)
    case "scaleto":
      self = .scaleTo(x: params.toDouble(0) ?? 0, y: params.toDouble(1) ?? 0)
    case "spin":
      self = .spin(repeatCount: params.toInt(0) ?? 1)
    case "compound", "array", "+":
      var params = params
      if let last = params.popLast() {
        var runP: Run
        if let run = Run(raw: last.name) {
          runP = run
        } else {
          params.append(last)
          runP = (node.name == "array") ? .sequential : .parallel
        }
        self = .compound(animations: params.map { AnimationType(node: $0) }, run: runP)
      } else {
        self = .none
      }
    default:
      self = .none
    }
  }

}

extension AnimationType {
  public static func + (lhs: inout AnimationType, rhs: AnimationType) -> AnimationType {
    switch (lhs, rhs) {
    case (.compound(let lanimation, .parallel), .compound(let ranimation, .parallel)):
      return .compound(animations: lanimation + ranimation, run: .parallel)
    case (.compound(let lanimation, .parallel), _):
      var animation = lanimation
      animation.append(rhs)
      return .compound(animations: animation, run: .parallel)
    case (_, .compound(let ranimation, .parallel)):
      var animation = ranimation
      animation.insert(lhs, at: 0)
      return .compound(animations: animation, run: .parallel)
    default:
      return .compound(animations: [lhs, rhs], run: .parallel)
    }
  }
}

extension AnimationType: ExpressibleByArrayLiteral {
  public typealias ArrayLiteralElement = AnimationType

  public init(arrayLiteral elements: AnimationType...) {
    if let first = elements.first {
      if elements.count == 1 {
        self = first
      } else if case let .compound(animation, .sequential) = first {
        self = .compound(animations: animation + Array(elements.dropFirst(1)), run: .sequential)
      } else {
        self = .compound(animations: elements, run: .sequential)
      }
    } else {
      self = .none
    }
  }

}
