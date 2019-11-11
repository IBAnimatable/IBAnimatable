//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

/**
 Predefined Transition Animation Type
 */
public enum TransitionAnimationType {
  case none
  case systemRotate
  case systemSuckEffect
  case systemRippleEffect
  case explode(xFactor: CGFloat?, minAngle: CGFloat?, maxAngle: CGFloat?)
  case fade(direction: Direction)
  case fold(from: Direction, folds: Int?)
  case portal(direction: Direction, zoomScale: CGFloat?)
  case slide(to: Direction, isFade: Bool)
  case natGeo(to: Direction)
  case turn(from: Direction)
  case cards(direction: Direction)
  case flip(from: Direction)
  case systemCube(from: Direction)
  case systemFlip(from: Direction)
  case systemMoveIn(from: Direction)
  case systemPush(from: Direction)
  case systemReveal(from: Direction)
  case systemPage(type: PageType)
  case systemCameraIris(hollowState: HollowState)

  public var stringValue: String {
    return String(describing: self)
  }
}

// MARK: - SystemType Initializers
// Uses TransitionAnimationType.SystemTransitionType to create TransitionAnimationType
extension TransitionAnimationType {
  init(systemType: SystemTransitionType, direction: Direction) {
    switch systemType {
    case .cube: self = .systemCube(from: direction)
    case .flip: self = .flip(from: direction)
    case .moveIn: self = .systemMoveIn(from: direction)
    case .push: self = .systemPush(from: direction)
    case .reveal: self = .systemReveal(from: direction)
    default: fatalError("SystemTransitionType Invalid")
    }
  }

  init(systemType: SystemTransitionType) {
    switch systemType {
    case .rotate: self = .systemRotate
    case .suckEffect: self = .systemSuckEffect
    case .rippleEffect: self = .systemRippleEffect
    case .pageCurl: self = .systemPage(type: .curl)
    case .pageUnCurl: self = .systemPage(type: .unCurl)
    case .cameraIris: self = .systemCameraIris(hollowState: .none)
    case .cameraIrisHollowOpen: self = .systemCameraIris(hollowState: .open)
    case .cameraIrisHollowClose: self = .systemCameraIris(hollowState: .close)
    default: fatalError("SystemTransitionType Requires Direction")
    }
  }
}

extension TransitionAnimationType {

  /// Reverses the direction of the animation
  var reversed: TransitionAnimationType {
    switch self {
    case let .fade(direction):
      return .fade(direction: direction.opposite)
    case let .fold(direction, folds):
      return .fold(from: direction.opposite, folds: folds)
    case let .portal(direction, scale):
      return .portal(direction: direction.opposite, zoomScale: scale)
    case let .slide(direction, isFade):
      return .slide(to: direction.opposite, isFade: isFade)
    case let .natGeo(direction):
      return .natGeo(to: direction.opposite)
    case let .turn(direction):
      return .turn(from: direction.opposite)
    case let .cards(direction):
      return .cards(direction: direction.opposite)
    case let .flip(direction):
      return .flip(from: direction.opposite)
    case let .systemCube(direction):
      return .systemCube(from: direction.opposite)
    case let .systemFlip(direction):
      return .systemFlip(from: direction.opposite)
    case let .systemMoveIn(direction):
      return .systemMoveIn(from: direction.opposite)
    case let .systemPush(direction):
      return .systemPush(from: direction.opposite)
    case let .systemReveal(direction):
      return .systemReveal(from: direction.opposite)
    case let .systemPage(type):
      return .systemPage(type: type.opposite)
    case let .systemCameraIris(state):
      return .systemCameraIris(hollowState: state.opposite)
    case .none, .systemRotate, .systemSuckEffect, .systemRippleEffect, .explode:
      return self
    }
  }
}

extension TransitionAnimationType: IBEnum {
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
    case "systemrippleeffect":
      self = .systemRippleEffect
    case "systemsuckeffect":
      self = .systemSuckEffect
    case "explode":
      if params.count == 3 {
        if let xFactor = params.toCGFloat(0),
          let minAngle = params.toCGFloat(1),
          let maxAngle = params.toCGFloat(2) {
          self = .explode(xFactor: xFactor, minAngle: minAngle, maxAngle: maxAngle)
          return
        }
      }
      self = .explode(xFactor: nil, minAngle: nil, maxAngle: nil)
    case "fade":
      self = .fade(direction: Direction(raw: params.toString(0), defaultValue: .cross))
    case "systemcamerairis":
      self = .systemCameraIris(hollowState: HollowState(raw: params.toString(0), defaultValue: .none))
    case "systempage":
      self = .systemPage(type: PageType(raw: params.toString(0), defaultValue: .curl))
    case "systemrotate":
      self = .systemRotate
    case "systemcube":
      self = .systemCube(from: Direction(raw: params.toString(0), defaultValue: .left))
    case "systemflip":
      self = .systemFlip(from: Direction(raw: params.toString(0), defaultValue: .left))
    case "systemmovein":
      self = .systemMoveIn(from: Direction(raw: params.toString(0), defaultValue: .left))
    case "systempush":
      self = .systemPush(from: Direction(raw: params.toString(0), defaultValue: .left))
    case "systemreveal":
      self = .systemReveal(from: Direction(raw: params.toString(0), defaultValue: .left))
    case "natgeo":
      self = .natGeo(to: Direction(raw: params.toString(0), defaultValue: .left))
    case "turn":
      self = .turn(from: Direction(raw: params.toString(0), defaultValue: .left))
    case "cards":
      self = .cards(direction: Direction(raw: params.toString(0), defaultValue: .left))
    case "flip":
      self = .flip(from: Direction(raw: params.toString(0), defaultValue: .left))
    case "fold":
      let direction = Direction(raw: params.toString(0), defaultValue: .left)
      if let folds = params.toInt(1) {
        self = .fold(from: direction, folds: folds)
      } else {
        self = .fold(from: direction, folds: nil)
      }
    case "portal":
      let direction = Direction(raw: params.toString(0), defaultValue: .left)
      if let zoomScale = params.toCGFloat(1) {
        self = .portal(direction: direction, zoomScale: zoomScale)
      } else {
        self = .portal(direction: direction, zoomScale: nil)
      }
    case "slide":
      let direction = Direction(raw: params.toString(0), defaultValue: .left)
      let isFade = params.contains("fade")
      self = .slide(to: direction, isFade: isFade)
    default:
      self = .none
    }
  }
}

// MARK: - `Direction`
extension TransitionAnimationType {
  /**
   Direction: used to specify the direction for the transition
   */
  public enum Direction: String {
    case left
    case right
    case top
    case bottom
    case forward
    case backward
    case `in`
    case out
    case cross

    // Convert from direction to CATransition Subtype used in `CATransition`
    var caTransitionSubtype: CATransitionSubtype? {
      switch self {
      case .left:
        return CATransitionSubtype.fromLeft
      case .right:
        return CATransitionSubtype.fromRight
      case .top:
        // The actual transition direction is oposite, need to reverse
        return CATransitionSubtype.fromBottom
      case .bottom:
        // The actual transition direction is oposite, need to reverse
        return CATransitionSubtype.fromTop
      default:
        return nil
      }
    }

    var isHorizontal: Bool {
      return self == .left || self == .right
    }

    static func fromString(forParams params: [Udra.Node]) -> Direction? {
      if params.contains("left") {
        return .left
      } else if params.contains("right") {
        return .right
      } else if params.contains("top") {
        return .top
      } else if params.contains("bottom") {
        return .bottom
      } else if params.contains("forward") {
        return .forward
      } else if params.contains("backward") {
        return .backward
      }
      return nil
    }

    var opposite: Direction {
      switch self {
      case .left:
        return .right
      case .right:
        return .left
      case .top:
        return .bottom
      case .bottom:
        return .top
      case .in:
        return .out
      case .out:
        return .in
      case .forward:
        return .backward
      case .backward:
        return .forward
      case .cross:
        return .cross
      }
    }

    /// Retrieves companion InteractiveGestureType.GestureDirection for Direction
    var matchingGesture: InteractiveGestureType.GestureDirection {
      switch self {
      case .left: return .left
      case .right: return .right
      case .top: return .top
      case .bottom: return .bottom
      case .forward: return .open
      case .backward: return .close
      default:
        fatalError("No matching GestureDirection for \(self)")
      }
    }

    /// Retrieves counterpart InteractiveGestureType.GestureDirection for Direction
    var opposingGesture: InteractiveGestureType.GestureDirection {
      switch self {
      case .left: return .right
      case .right: return .left
      case .top: return .bottom
      case .bottom: return .top
      case .forward: return .close
      case .backward: return .open
      default:
        fatalError("No opposing GestureDirection for \(self)")
      }
    }
  }
}

// MARK: - `TransitionHollowState`
extension TransitionAnimationType {
  /**
   Hollow state: used to specify the hollow state for `systemCameraIris` transition
   */
  public enum HollowState: String {
    case none
    case open
    case close

    var opposite: HollowState {
      switch self {
      case .close: return .open
      case .open: return .close
      case .none: return .none
      }
    }

    var opposingGesture: InteractiveGestureType.GestureDirection {
      switch self {
      case .open: return .close
      case .close: return .open
      case .none:
        fatalError("No opposing GestureDirection for HollowState.none")
      }
    }
  }
}

// MARK: - `PageType`
extension TransitionAnimationType {
  /**
   Page type: used to specify the page type for `systemPage` transition
   */
  public enum PageType: String {
    case curl
    case unCurl

    var opposite: PageType {
      switch self {
      case .curl: return .unCurl
      case .unCurl: return .curl
      }
    }
  }
}

// MARK: - `SystemTransitionType`
extension TransitionAnimationType {
  /**
   System transition type: map to iOS built-in CATransition Type
   refer to http://iphonedevwiki.net/index.php/CATransition
   */
  public enum SystemTransitionType: String {
    case fade     // kCATransitionFade
    case moveIn   // kCATransitionMoveIn
    case push     // kCATransitionPush
    case reveal   // kCATransitionReveal
    case flip
    case cube
    case pageCurl
    case pageUnCurl
    case rippleEffect
    case suckEffect
    case cameraIris
    case cameraIrisHollowOpen
    case cameraIrisHollowClose
    case rotate

    init(pageType: PageType) {
      switch pageType {
      case .curl: self = .pageCurl
      case .unCurl: self = .pageUnCurl
      }
    }

    init(hollowState: HollowState) {
      switch hollowState {
      case .open: self = .cameraIrisHollowOpen
      case .close: self = .cameraIrisHollowClose
      case .none: self = .cameraIris
      }
    }
  }
}

extension TransitionAnimationType: Hashable {
  #if swift(>=4.2)
  public func hash(into hasher: inout Hasher) {
    hasher.combine(stringValue)
  }
  #else
  public var hashValue: Int { // swiftlint:disable:this legacy_hashing
    return stringValue.hashValue
  }
  #endif

  public static func == (lhs: TransitionAnimationType, rhs: TransitionAnimationType) -> Bool {
    return lhs.stringValue == rhs.stringValue
  }
}
