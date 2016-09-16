//
//  Created by Tom Baranes on 17/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public enum PresentationModalPosition: IBEnum {

  case center
  case topCenter
  case bottomCenter
  case leftCenter
  case rightCenter
  case customCenter(centerPoint: CGPoint)
  case customOrigin(origin: CGPoint)

  func calculateCenter(containerBounds: CGRect, modalSize: CGSize) -> CGPoint? {
    switch self {
    case .center:
      return CGPoint(x: containerBounds.width / 2, y: containerBounds.height / 2)
    case .topCenter:
      return CGPoint(x: containerBounds.width / 2, y: modalSize.height / 2)
    case .bottomCenter:
      return CGPoint(x: containerBounds.width / 2, y: containerBounds.height - modalSize.height / 2)
    case .leftCenter:
      return CGPoint(x: modalSize.width / 2, y: containerBounds.height / 2)
    case .rightCenter:
      return CGPoint(x: containerBounds.width - modalSize.width / 2, y: containerBounds.height / 2)
    case let .customCenter(point):
      return point
    case .customOrigin(_):
      return nil
    }
  }

  func calculateOrigin() -> CGPoint? {
    switch self {
    case let .customOrigin(origin):
      return origin
    default:
      return nil
    }
  }
  
}

public extension PresentationModalPosition {
  /**
   Initializes a swift `PresentationModalPosition` with provided optional string
   
   - Parameter string: The optional string to be converted into `PresnetationModalPosition`.
   */
  public init(string: String?) {
    guard let string = string else {
      self = .center
      return 
    }
    
    let nameAndParames = MaskType.extractNameAndParams(from: string)
    let name = nameAndParames.name
    let params = nameAndParames.params
    let point = CGPoint(x: params[safe: 0]?.toDouble() ?? 0, y: params[safe: 1]?.toDouble() ?? 0)
    
    switch name {
      case "center":
      self = .center
      case "topcenter":
      self = .topCenter
      case "bottomcenter":
      self = .bottomCenter
      case "leftcenter":
      self = .leftCenter
      case "rightcenter":
      self = .rightCenter
      case "customcenter" where params.count > 2:
      self = .customCenter(centerPoint: point)
    case "customorigin" where params.count > 2:
      self = .customOrigin(origin: point)
    default:
      self = .center
    }
  }
  
}
