//
//  UserInterfaceTableViewController.swift
//  IBAnimatableApp
//
//  Created by jason akakpo on 07/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation
import UIKit

final class UserInterfaceGradientsTableViewController: UITableViewController {

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let gradientVC = segue.destination as? GradientViewController {
      gradientVC.usePredefinedGradient = segue.identifier?.lowercased().contains("predefined") ?? false
      gradientVC.useRadialGradient = segue.identifier?.lowercased().contains("radial") ?? false
    } else if let gradientVC = segue.destination as? GradientCustomStartPointViewController {
      gradientVC.useRadialGradient = segue.identifier?.lowercased().contains("radial") ?? false
    }
  }
}
