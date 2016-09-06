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
  // TODO: params can be typealiase
  case explode(params: [String])
  case fade(direction: Direction)
  case fold(from: Direction, folds: Int?)
  case portal(direction: Direction, params: [String])
  case slide(toDirection: Direction, params: [String])
  case natGeo(toDirection: Direction)
  case turn(fromDirection: Direction)
  case cards(direction: Direction)
  case flip(fromDirection: Direction)
  case systemCube(fromDirection: Direction)
  case systemFlip(fromDirection: Direction)
  case systemMoveIn(fromDirection: Direction)
  case systemPush(fromDirection: Direction)
  case systemReveal(fromDirection: Direction)
  case systemPage(type: PageType)
  case systemCameraIris(hollowState: HollowState)
  
  public var stringValue: String {
    return String(describing: self)
  }
}

extension TransitionAnimationType: IBEnum {
  public init(string: String?) {
    guard let string = string else {
      self = .none
      return
    }
    
    let nameAndParams = TransitionAnimationType.extractNameAndParams(from: string)
    let name = nameAndParams.name
    let params = nameAndParams.params
    
    switch name {
    case "systemrippleeffect":
      self = .systemRippleEffect
    case "systemsuckeffect":
      self = .systemSuckEffect
    case "Explode":
      self = .explode(params: params)
    case "Fade":
      self = .fade(direction: Direction(raw: params[safe: 0], defaultValue: .cross))
    case "systemcamerairis":
      self = .systemCameraIris(hollowState: HollowState(raw: params[safe: 0], defaultValue: .none))
    case "systempage":
      self = .systemPage(type: PageType(raw: params[safe: 0], defaultValue: .curl))
    case "systemrotate":
      self = .systemRotate
    case "systemcube":
      self = .systemCube(fromDirection: Direction(raw: params[safe: 0], defaultValue: .left))
    case "systemflip":
      self = .systemFlip(fromDirection: Direction(raw: params[safe: 0], defaultValue: .left))
    case "systemmovein":
      self = .systemMoveIn(fromDirection: Direction(raw: params[safe: 0], defaultValue: .left))
    case "systempush":
      self = .systemPush(fromDirection: Direction(raw: params[safe: 0], defaultValue: .left))
    case "systemreveal":
      self = .systemReveal(fromDirection: Direction(raw: params[safe: 0], defaultValue: .left))
    case "natgeo":
      self = .natGeo(toDirection: Direction(raw: params[safe: 0], defaultValue: .left))
    case "turn":
      self = .turn(fromDirection: Direction(raw: params[safe: 0], defaultValue: .left))
    case "cards":
      self = .cards(direction: Direction(raw: params[safe: 0], defaultValue: .left))
    case "flip":
      self = .flip(fromDirection: Direction(raw: params[safe: 0], defaultValue: .left))
    case "fold":
      let direction = Direction(raw: params[safe: 0], defaultValue: .left)
      if let foldsString = params[safe: 1], let folds = Int(foldsString) {
        self = .fold(from: direction, folds: folds)
      } else {
        self = .fold(from: direction, folds: nil)
      }
    case "portal":
      let direction = Direction(raw: params[safe: 0], defaultValue: .left)
      var params = params
      params.removeFirst()
      self = .portal(direction: direction, params: params)
    case "slide":
      let direction = Direction(raw: params[safe: 0], defaultValue: .left)
      var params = params
      params.removeFirst()
      self = .slide(toDirection: direction, params: params)
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
    var caTransitionSubtype: String {
      switch self {
      case .left:
        return kCATransitionFromLeft
      case .right:
        return kCATransitionFromRight
      case .top:
        // The actual transition direction is oposite, need to reverse
        return kCATransitionFromBottom
      case .bottom:
        // The actual transition direction is oposite, need to reverse
        return kCATransitionFromTop
      default:
        return ""
      }
    }
    
    var isHorizontal: Bool {
      return self == .left || self == .right
    }
    
    static func fromString(forParams params: [String]) -> Direction? {
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
  }
}
