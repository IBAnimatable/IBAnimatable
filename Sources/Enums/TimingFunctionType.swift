//
//  Created by phimage on 19/04/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit

public enum TimingFunctionType {
  // well known tining functions
  case linear
  case easeIn
  case easeOut
  case easeInOut
  case `default`

  // not defined
  case none

  // custom one
  case custom((x: Float, y: Float), (x: Float, y: Float))
  case spring(damping: Float)

  // from http://easings.net/
  case easeInSine, easeOutSine, easeInOutSine
  case easeInCubic, easeOutCubic, easeInOutCubic
  case easeInQuad, easeOutQuad, easeInOutQuad
  case easeInQuart, easeOutQuart, easeInOutQuart
  case easeInQuint, easeOutQuint, easeInOutQuint
  case easeInExpo, easeOutExpo, easeInOutExpo
  case easeInCirc, easeOutCirc, easeInOutCirc
  case easeInBack, easeOutBack, easeInOutBack
}

extension TimingFunctionType: IBEnum {

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
    // standards
    case "linear":
      self = .linear
    case "easein":
      self = .easeIn
    case "easeout":
      self = .easeOut
    case "easeinout":
      self = .easeInOut
    case "default":
      self = .default

    // customs
    case "spring" where params.count == 1:
      self = .spring(damping: params.toFloat(0) ?? 0)
    case "custom" where params.count == 4:
      let c1 = (params.toFloat(0) ?? 0, params.toFloat(1) ?? 0)
      let c2 = (params.toFloat(2) ?? 0, params.toFloat(3) ?? 0)
      self = .custom(c1, c2)

    // from http://easings.net/
    case "easeinsine":
      self = .easeInSine
    case "easeoutsine":
      self = .easeOutSine
    case "easeinoutsine":
      self = .easeInOutSine
    case "easeinquad":
      self = .easeInQuad
    case "easeoutquad":
      self = .easeOutQuad
    case "easeinoutquad":
      self = .easeInOutQuad
    case "easeincubic":
      self = .easeInCubic
    case "easeoutcubic":
      self = .easeOutCubic
    case "easeinoutcubic":
      self = .easeInOutCubic
    case "easeinquart":
      self = .easeInQuart
    case "easeoutquart":
      self = .easeOutQuart
    case "easeinoutquart":
      self = .easeInOutQuart
    case "easeinquint":
      self = .easeInQuint
    case "easeoutquint":
      self = .easeOutQuint
    case "easeinoutquint":
      self = .easeInOutQuint
    case "easeinexpo":
      self = .easeInExpo
    case "easeoutexpo":
      self = .easeOutExpo
    case "easeinoutexpo":
      self = .easeInOutExpo
    case "easeincirc":
      self = .easeInCirc
    case "easeoutcirc":
      self = .easeOutCirc
    case "easeinoutcirc":
      self = .easeInOutCirc
    case "easeinback":
      self = .easeInBack
    case "easeoutback":
      self = .easeOutBack
    case "easeinoutback":
      self = .easeInOutBack

    // default case
    default:
      self = .none
    }
  }

}

extension TimingFunctionType: Hashable {

  public static func == (left: TimingFunctionType, right: TimingFunctionType) -> Bool {
    switch (left, right) {
    case (.none, .none):
      return true
    case (.none, _):
      return false
    case (_, none):
      return false
    default:
      return left.caType == right.caType
    }
  }

  #if swift(>=4.2)
  public func hash(into hasher: inout Hasher) {
    hasher.combine(caType)
  }
  #else
  public var hashValue: Int { // swiftlint:disable:this legacy_hashing
    return caType.hashValue
  }
  #endif
}

extension TimingFunctionType {

  public static func ?? (left: TimingFunctionType, right:  @autoclosure () throws -> TimingFunctionType) rethrows -> TimingFunctionType {
    switch left {
    case .none:
      return try right()
    default:
      return left
    }
  }

}
extension TimingFunctionType {

  public var caType: CAMediaTimingFunction {
    switch self {
    // standards
    case .linear:
      return .linear
    case .easeIn:
      return .easeIn
    case .easeOut:
      return .easeOut
    case .easeInOut:
      return .easeInOut
    case .default:
      return .default

    // customs
    case .spring(let damping):
      return CAMediaTimingFunction(controlPoints: 0.5, 1.1 + (damping / 3.0), 1, 1)
    case .custom(let c1, let c2):
      return CAMediaTimingFunction(controlPoints: c1.x, c1.y, c2.x, c2.y)

    // from http://easings.net/
    case .easeInSine:
      return .easeInSine
    case .easeOutSine:
      return .easeOutSine
    case .easeInOutSine:
      return .easeInOutSine
    case .easeInQuad:
      return .easeInQuad
    case .easeOutQuad:
      return .easeOutQuad
    case .easeInOutQuad:
      return .easeInOutQuad
    case .easeInCubic:
      return .easeInCubic
    case .easeOutCubic:
      return .easeOutCubic
    case .easeInOutCubic:
      return .easeInOutCubic
    case .easeInQuart:
      return .easeInQuart
    case .easeOutQuart:
      return .easeOutQuart
    case .easeInOutQuart:
      return .easeInOutQuart
    case .easeInQuint:
      return .easeInQuint
    case .easeOutQuint:
      return .easeOutQuint
    case .easeInOutQuint:
      return .easeInOutQuint
    case .easeInExpo:
      return .easeInExpo
    case .easeOutExpo:
      return .easeOutExpo
    case .easeInOutExpo:
      return .easeInOutExpo
    case .easeInCirc:
      return .easeInCirc
    case .easeOutCirc:
      return .easeOutCirc
    case .easeInOutCirc:
      return .easeInOutCirc
    case .easeInBack:
      return .easeInBack
    case .easeOutBack:
      return .easeOutBack
    case .easeInOutBack:
      return .easeInOutBack

    // default case
    case .none:
      return .default
    }
  }

}

extension TimingFunctionType {

  var viewAnimationCurveOption: UIView.AnimationOptions? {
    switch self {
    case .linear:
      return .curveLinear
    case .easeIn:
      return .curveEaseIn
    case .easeOut:
      return .curveEaseOut
    case .easeInOut:
      return .curveEaseInOut
    default:
      return nil
    }
  }

  var isCurveOption: Bool {
    switch self {
    case .linear, .easeIn, .easeOut, .easeInOut:
      return true
    default :
      return false
    }
  }

}

@available(iOS 10.0, *)
extension TimingFunctionType {
  var cubicTimingParameters: UICubicTimingParameters {
    switch self {
    case .custom(let c1, let c2):
      let cP1 = CGPoint(x: CGFloat(c1.x), y: CGFloat(c1.y))
      let cP2 = CGPoint(x: CGFloat(c2.x), y: CGFloat(c2.y))
      return UICubicTimingParameters(controlPoint1: cP1, controlPoint2: cP2)
    default:
      // Get control points from `CAMediaTimingFunction`
      // (could also return it directly by doing a big switch)
      let (c1, c2) = self.caType.controlPoints
      let cP1 = CGPoint(x: CGFloat(c1.x), y: CGFloat(c1.y))
      let cP2 = CGPoint(x: CGFloat(c2.x), y: CGFloat(c2.y))
      return UICubicTimingParameters(controlPoint1: cP1, controlPoint2: cP2)
    }
  }
}

// MARK: CoreAnimation

extension CAMediaTimingFunction {

  // standards
  @nonobjc public static let linear = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
  @nonobjc public static let easeIn = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
  @nonobjc public static let easeOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
  @nonobjc public static let easeInOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
  @nonobjc public static let `default`  = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)

  // http://easings.net/
  @nonobjc public static let easeInSine = CAMediaTimingFunction(controlPoints: 0.47, 0, 0.745, 0.715)
  @nonobjc public static let easeOutSine = CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1)
  @nonobjc public static let easeInOutSine = CAMediaTimingFunction(controlPoints: 0.445, 0.05, 0.55, 0.95)

  @nonobjc public static let easeInQuad = CAMediaTimingFunction(controlPoints: 0.55, 0.085, 0.68, 0.53)
  @nonobjc public static let easeOutQuad = CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94)
  @nonobjc public static let easeInOutQuad = CAMediaTimingFunction(controlPoints: 0.455, 0.03, 0.515, 0.955)

  @nonobjc public static let easeInCubic = CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
  @nonobjc public static let easeOutCubic = CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
  @nonobjc public static let easeInOutCubic = CAMediaTimingFunction(controlPoints: 0.645, 0.045, 0.355, 1)

  @nonobjc public static let easeInQuart = CAMediaTimingFunction(controlPoints: 0.895, 0.03, 0.685, 0.22)
  @nonobjc public static let easeOutQuart = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
  @nonobjc public static let easeInOutQuart = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)

  @nonobjc public static let easeInQuint = CAMediaTimingFunction(controlPoints: 0.755, 0.05, 0.855, 0.06)
  @nonobjc public static let easeOutQuint = CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)
  @nonobjc public static let easeInOutQuint = CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)

  @nonobjc public static let easeInExpo = CAMediaTimingFunction(controlPoints: 0.95, 0.05, 0.795, 0.035)
  @nonobjc public static let easeOutExpo = CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
  @nonobjc public static let easeInOutExpo = CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)

  @nonobjc public static let easeInCirc = CAMediaTimingFunction(controlPoints: 0.6, 0.04, 0.98, 0.335)
  @nonobjc public static let easeOutCirc = CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1)
  @nonobjc public static let easeInOutCirc = CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)

  @nonobjc public static let easeInBack = CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
  @nonobjc public static let easeOutBack = CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
  @nonobjc public static let easeInOutBack = CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)

}

extension CAMediaTimingFunction {

  /// Return the control points of the timing function.
  public var controlPoints: ((x: Float, y: Float), (x: Float, y: Float)) {
    var cps = [Float](repeating: 0, count: 4)
    getControlPoint(at: 0, values: &cps[0])
    getControlPoint(at: 1, values: &cps[1])
    getControlPoint(at: 2, values: &cps[2])
    getControlPoint(at: 3, values: &cps[3])
    return ((cps[0], cps[1]), (cps[2], cps[3]))
  }

}

internal extension CAAnimation {

  // convenient setter, getter not implemented
  var timingFunctionType: TimingFunctionType? {
    get {
      fatalError("You cannot read timingFunctionType, read instead timingFunction.")
    }
    set {
      self.timingFunction = newValue?.caType
    }
  }

}

internal extension CAKeyframeAnimation {
  var timingFunctionsType: [TimingFunctionType]? {
    get {
      fatalError("You cannot read timingFunctionType, read instead timingFunction.")
    }
    set {
      if let types = newValue {
        self.timingFunctions = types.map { $0.caType }
      } else {
        self.timingFunctions = nil
      }
    }
  }
}
