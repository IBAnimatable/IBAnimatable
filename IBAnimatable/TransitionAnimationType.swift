//
//  Created by Jake Lin on 2/24/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation

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
  case fade(direction: TransitionDirection)
  case fold(fromDirection: TransitionDirection, params: [String])
  case portal(direction: TransitionDirection, params: [String])
  case slide(toDirection: TransitionDirection, params: [String])
  case natGeo(toDirection: TransitionDirection)
  case turn(fromDirection: TransitionDirection)
  case cards(direction: TransitionDirection)
  case flip(fromDirection: TransitionDirection)
  case systemCube(fromDirection: TransitionDirection)
  case systemFlip(fromDirection: TransitionDirection)
  case systemMoveIn(fromDirection: TransitionDirection)
  case systemPush(fromDirection: TransitionDirection)
  case systemReveal(fromDirection: TransitionDirection)
  case systemPage(type: TransitionPageType)
  case systemCameraIris(hollowState: TransitionHollowState)
  
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
      self = .fade(direction: TransitionDirection(raw: params[safe: 0], defaultValue: .cross))
    case "systemcamerairis":
      self = .systemCameraIris(hollowState: TransitionHollowState(raw: params[safe: 0], defaultValue: .none))
    case "systempage":
      self = .systemPage(type: TransitionPageType(raw: params[safe: 0], defaultValue: .curl))
    case "systemrotate":
      self = .systemRotate
    case "systemcube":
      self = .systemCube(fromDirection: TransitionDirection(raw: params[safe: 0], defaultValue: .left))
    case "systemflip":
      self = .systemFlip(fromDirection: TransitionDirection(raw: params[safe: 0], defaultValue: .left))
    case "systemmovein":
      self = .systemMoveIn(fromDirection: TransitionDirection(raw: params[safe: 0], defaultValue: .left))
    case "systempush":
      self = .systemPush(fromDirection: TransitionDirection(raw: params[safe: 0], defaultValue: .left))
    case "systemreveal":
      self = .systemReveal(fromDirection: TransitionDirection(raw: params[safe: 0], defaultValue: .left))
    case "natgeo":
      self = .natGeo(toDirection: TransitionDirection(raw: params[safe: 0], defaultValue: .left))
    case "turn":
      self = .turn(fromDirection: TransitionDirection(raw: params[safe: 0], defaultValue: .left))
    case "cards":
      self = .cards(direction: TransitionDirection(raw: params[safe: 0], defaultValue: .left))
    case "flip":
      self = .flip(fromDirection: TransitionDirection(raw: params[safe: 0], defaultValue: .left))
    case "fold":
      let direction = TransitionDirection(raw: params[safe: 0], defaultValue: .left)
      var params = params
      params.removeFirst()
      self = .fold(fromDirection: direction, params: params)
    case "portal":
      let direction = TransitionDirection(raw: params[safe: 0], defaultValue: .left)
      var params = params
      params.removeFirst()
      self = .portal(direction: direction, params: params)
    case "slide":
      let direction = TransitionDirection(raw: params[safe: 0], defaultValue: .left)
      var params = params
      params.removeFirst()
      self = .slide(toDirection: direction, params: params)
    default:
      self = .none
    }
    
  }
}
