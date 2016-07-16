//
//  PresentationDesignable.swift
//  IBAnimatableApp
//

import UIKit

public protocol PresentationDesignable: class {
    
  var roundCorners: Bool { get set }
  var dismissOnTap: Bool { get set }
  var backgroundColor: UIColor { get set }
  var backgroundOpacity: Float { get set }

}

public struct PresentedSetup {
  var roundCorners: Bool = true
  var dismissOnTap: Bool = true
  var backgroundColor: UIColor = .blackColor()
  var backgroundOpacity: Float = 0.7
}
