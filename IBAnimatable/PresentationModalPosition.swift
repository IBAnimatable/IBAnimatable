//
//  Created by Tom Baranes on 17/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

public enum PresentationModalPosition {

  case Center
  case TopCenter
  case BottomCenter
  case LeftCenter
  case RightCenter
  case CustomCenter(centerPoint: CGPoint)
  case CustomOrigin(origin: CGPoint)

  func calculateCenter(containerBounds: CGRect, modalSize: CGSize) -> CGPoint? {
    switch self {
    case .Center:
      return CGPoint(x: containerBounds.width / 2, y: containerBounds.height / 2)
    case .TopCenter:
      return CGPoint(x: containerBounds.width / 2, y: modalSize.height / 2)
    case .BottomCenter:
      return CGPoint(x: containerBounds.width / 2, y: containerBounds.height - modalSize.height / 2)
    case .LeftCenter:
      return CGPoint(x: modalSize.width / 2, y: containerBounds.height / 2)
    case .RightCenter:
      return CGPoint(x: containerBounds.width - modalSize.width / 2, y: containerBounds.height / 2)
    case let .CustomCenter(point):
      return point
    case .CustomOrigin(_):
      return nil
    }
  }

  func calculateOrigin() -> CGPoint? {
    switch self {
    case let .CustomOrigin(origin):
      return origin
    default:
      return nil
    }
  }
  
}

extension PresentationModalPosition {

  public static func fromString(position: String) -> PresentationModalPosition {
    if position.hasPrefix("Center") {
      return .Center
    } else if position.hasPrefix("TopCenter") {
      return .TopCenter
    } else if position.hasPrefix("BottomCenter") {
      return .BottomCenter
    } else if position.hasPrefix("LeftCenter") {
      return .LeftCenter
    } else if position.hasPrefix("RightCenter") {
      return .RightCenter
    }
    return fromStringWithParameters(position)
  }


  static func fromStringWithParameters(position: String) -> PresentationModalPosition {
    let posParams = params(forPosition: position)
    guard posParams.count >= 2 else {
      return .Center
    }

    guard let x = Float(posParams[0]), y = Float(posParams[1]) else {
      return .Center
    }

    if position.hasPrefix("CustomCenter") {
      return .CustomCenter(centerPoint: CGPoint(x: CGFloat(x), y: CGFloat(y)))
    } else if position.hasPrefix("CustomOrigin") {
      return .CustomOrigin(origin: CGPoint(x: CGFloat(x), y: CGFloat(y)))
    }
    return .Center
  }

}

private extension PresentationModalPosition {

  static func params(forPosition position: String) -> [String] {
    let range = position.rangeOfString("(")
    let position = position.stringByReplacingOccurrencesOfString(" ", withString: "")
      .lowercaseString
      .substringFromIndex(range?.startIndex ?? position.endIndex)
      .stringByReplacingOccurrencesOfString("(", withString: "")
      .stringByReplacingOccurrencesOfString(")", withString: "")
    return position.componentsSeparatedByString(",")
  }

}
