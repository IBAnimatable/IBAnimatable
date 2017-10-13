//
//  PresentOverContextSegue.swift
//  IBAnimatable
//
//  Created by Tom Baranes on 30/03/2017.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import UIKit

open class PresentOverCurrentContextSegue: UIStoryboardSegue {
  open override func perform() {
    if let modalVC = destination as? AnimatableModalViewController {
      let source = self.source
      modalVC.contextFrameForPresentation = {
        let correctedOrigin = source.view.convert(source.view.frame.origin, to: nil)
        return CGRect(origin: correctedOrigin, size: source.view.bounds.size)
      }
    }
    source.present(destination, animated: true, completion: nil)
  }
}
