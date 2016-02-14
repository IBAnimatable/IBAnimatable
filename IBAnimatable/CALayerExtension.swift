//
//  CALayerExtension.swift
//  IBAnimatableApp
//
//  Created by Tom Baranes on 14/02/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

extension CALayer {

  func removeSublayerWithName(layerName: String) {
    guard let unwrappedSublayers = sublayers else {
      return
    }
    
    let oldLayer = unwrappedSublayers.filter { $0.name == layerName }
    if let unwrappedOldLayer = oldLayer.first,
           layerIndex =  unwrappedSublayers.indexOf(unwrappedOldLayer) {
            sublayers?.removeAtIndex(layerIndex)
    }
  }
}