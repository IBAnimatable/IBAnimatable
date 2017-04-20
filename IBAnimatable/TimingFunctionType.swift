//
//  Created by phimage on 19/04/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit

public enum TimingFunctionType {

  case linear
  case easeIn
  case easeOut
  case easeInOut
  case `default`

  // #12 use a none or use optional with nil as default value in Animatable??
  case none

  // #12 sprint one?
  // case spring(damping: CGFloat)

  // #12 add a custom one?
  // case custom(c1X Float, c1y: Float, c2x: Float, c2y: Float) // or named controlPoints

  // http://easings.net/
  case easeInSine, easeOutSine, easeInOutSine
  case easeInCubic, easeOutCubic, easeInOutCubic
  // #12 add more types

}

extension TimingFunctionType: IBEnum {

  public init(string: String?) {
    guard let string = string else {
      self = .none
      return
    }

    let (name, _) = TimingFunctionType.extractNameAndParams(from: string)

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
    case "easeInSine":
      self = .easeInSine
    case "easeOutSine":
      self = .easeOutSine
    case "easeInOutSine":
      self = .easeInOutSine
    case "easeInCubic":
      self = .easeInCubic
    case "easeOutCubic":
      self = .easeOutCubic
    case "easeInOutCubic":
      self = .easeInOutCubic

    default:
      self = .none
    }
  }

}

extension TimingFunctionType {

  var caType: CAMediaTimingFunction {
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

      // case .spring(let damping):
      //  return CAMediaTimingFunction(controlPoints: 0.5, 1.1 + (Float(damping) / 3.0), 1, 1)

      //case .custom(let c1x, let c1y, let c2x, let c2y):
      //  return CAMediaTimingFunction(controlPoints: c1x, c1y, c2x, c2y)

    // customs
    case .easeInSine:
      return .easeInSine
    case .easeOutSine:
      return .easeOutSine
    case .easeInOutSine:
      return .easeInOutSine
    case .easeInCubic:
      return .easeInCubic
    case .easeOutCubic:
      return .easeOutCubic
    case .easeInOutCubic:
      return .easeInOutCubic

    case .none:
      return .default // #12 return nil and use optional?
    }
  }

}

extension TimingFunctionType {

  var viewAnimationCurveOption: UIViewAnimationOptions? {
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

}

// MARK: CoreAnimation

extension CAMediaTimingFunction {

  @nonobjc public static let linear = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
  @nonobjc public static let easeIn = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
  @nonobjc public static let easeOut = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
  @nonobjc public static let easeInOut = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
  @nonobjc public static let `default`  = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)

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

internal extension CAAnimation {

  // conveniant setter, getter not implemented
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
