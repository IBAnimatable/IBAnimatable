//
//  AnimatablePresentedViewController.swift
//  IBAnimatableApp
//

import UIKit

public class AnimatablePresentedViewController: UIViewController, PresentationDesignable {

  // MARK: - TransitionAnimatable    
  @IBInspectable public var roundCorners: Bool = true
  @IBInspectable public var dismissOnTap: Bool = true
  @IBInspectable public var backgroundColor: UIColor = .blackColor()
  @IBInspectable public var backgroundOpacity: Float = 0.7

  // MARK: Life cycle

  override public func viewDidLoad() {
    super.viewDidLoad()
  }
  
}
