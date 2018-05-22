//
//  UserInterfaceTableViewController.swift
//  IBAnimatableApp
//
//  Created by jason akakpo on 07/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation
import UIKit
import IBAnimatable

final class UserInterfaceGradientsTableViewController: UITableViewController {

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let identifier = segue.identifier?.lowercased() {
      if let gradientVC = segue.destination as? GradientViewController {
        gradientVC.usePredefinedGradient = identifier.contains("predefined")
      }
      if var gradientVC = segue.destination as? GradientModePresenter {
        if identifier.contains("radial") {
          gradientVC.gradientMode = .radial
        } else if identifier.contains("conical") {
          gradientVC.gradientMode = .conical
        } else {
          gradientVC.gradientMode = .linear
        }
      }
    }
  }
}

protocol GradientModePresenter {
  var gradientMode: GradientMode { get set }
}
