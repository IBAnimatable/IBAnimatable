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

    let (name, params) = AnimationType.extractNameAndParams(from: string.parseNameAndParams)

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
    case "zoominvert":
      self = .zoomInvert(way: Way(raw: params[safe: 0], defaultValue: .in))
    case "shake":
      let repeatCount = retrieveRepeatCount(string: params[safe: 0])
      self = .shake(repeatCount: repeatCount)
    case "pop":
      let repeatCount = retrieveRepeatCount(string: params[safe: 0])
      self = .pop(repeatCount: repeatCount)
    case "squash":
      let repeatCount = retrieveRepeatCount(string: params[safe: 0])
      self = .squash(repeatCount: repeatCount)
    case "flip":
      let axis = Axis(raw: params[safe: 0], defaultValue: .x)
      self = .flip(along: axis)
    case "morph":
      let repeatCount = retrieveRepeatCount(string: params[safe: 0])
      self = .morph(repeatCount: repeatCount)
    case "flash":
      let repeatCount = retrieveRepeatCount(string: params[safe: 0])
      self = .flash(repeatCount: repeatCount)
    case "wobble":
      let repeatCount = retrieveRepeatCount(string: params[safe: 0])
      self = .wobble(repeatCount: repeatCount)
    case "swing":
      let repeatCount = retrieveRepeatCount(string: params[safe: 0])
      self = .swing(repeatCount: repeatCount)
    case "rotate":
      let repeatCount = retrieveRepeatCount(string: params[safe: 1])
      self = .rotate(direction: RotationDirection(raw: params[safe: 0], defaultValue: .cw), repeatCount: repeatCount)
    case "moveto":
      self = .moveTo(x: params[safe: 0]?.toDouble() ?? 0, y: params[safe: 1]?.toDouble() ?? 0)
    case "moveby":
      self = .moveBy(x: params[safe: 0]?.toDouble() ?? 0, y: params[safe: 1]?.toDouble() ?? 0)
    case "scale":
      let fromX = params[safe: 0]?.toDouble() ?? 0
      let fromY = params[safe: 1]?.toDouble() ?? 0
      let toX = params[safe: 2]?.toDouble() ?? 1
      let toY = params[safe: 3]?.toDouble() ?? 1
      self = .scale(fromX: fromX, fromY: fromY, toX: toX, toY: toY)
    case "scalefrom":
      self = .scaleFrom(x: params[safe: 0]?.toDouble() ?? 0, y: params[safe: 1]?.toDouble() ?? 0)
    case "scaleto":
      self = .scaleTo(x: params[safe: 0]?.toDouble() ?? 0, y: params[safe: 1]?.toDouble() ?? 0)
    case "spin":
      let repeatCount = retrieveRepeatCount(string: params[safe: 0])
      self = .spin(repeatCount: repeatCount)
    case "compound":
      var params = params
      if let last = params.popLast() {
        var runP: Run
        if let run = Run(raw: last) {
          runP = run
        } else {
          params.append(last)
          runP = .parallel
        }
        self = .compound(animations: params.map { $0.animationType ?? .none }, run: runP)
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

private extension String {

  var parseNameAndParams: String {
    var string = self
    if string.starts(with: "[") { // [ animation1, animation2, ...]
      string = string.dropFirst().dropLast()
        .replacingOccurrences(of: "(", with: "[")
        .replacingOccurrences(of: ")", with: "]")
      string = "compound("+string+", \(AnimationType.Run.sequential.rawValue))"
    } else if string.contains("+") { // animation1 + animation2 + ...
      string = string.replacingOccurrences(of: "+", with: ",")
      string = "compound("+string+", \(AnimationType.Run.parallel.rawValue))"
    }
    return string
  }

  var animationType: AnimationType? {
    let type = self.replacingOccurrences(of: "[", with: "(")
      .replacingOccurrences(of: "]", with: ")")
    return AnimationType(string: type)
  }
}
private func retrieveRepeatCount(string: String?) -> Int {
  // Default value for repeat count is `1`
  guard let string = string, let repeatCount = Int(string) else {
    return 1
  }

  return repeatCount
}
