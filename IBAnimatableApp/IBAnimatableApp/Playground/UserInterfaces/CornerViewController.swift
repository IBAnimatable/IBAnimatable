//
//  CornerViewController.swift
//  IBAnimatable
//
//  Created by Miroslav Valkovic-Madjer on 17/11/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit
import IBAnimatable

final class CornerViewController: UIViewController {

  @IBOutlet fileprivate weak var viewToCorner: AnimatableView!
  @IBOutlet fileprivate weak var topLeftCheckBox: AnimatableCheckBox!
  @IBOutlet fileprivate weak var topRightCheckBox: AnimatableCheckBox!
  @IBOutlet fileprivate weak var bottomLeftCheckBox: AnimatableCheckBox!
  @IBOutlet fileprivate weak var bottomRightCheckBox: AnimatableCheckBox!

  @IBAction func boxChecked(_ sender: AnimatableCheckBox) {
    let corner: CornerSides

    switch sender {
    case topLeftCheckBox:
      corner = .topLeft
    case topRightCheckBox:
      corner = .topRight
    case bottomLeftCheckBox:
      corner = .bottomLeft
    case bottomRightCheckBox:
      corner = .bottomRight
    default:
      return
    }

    if sender.checked {
      viewToCorner.cornerSides.insert(corner)
    } else {
      viewToCorner.cornerSides.remove(corner)
    }

  }

}
