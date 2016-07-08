//
//  Utils.swift
//  IBAnimatableApp
//
//  Created by jason akakpo on 03/07/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

internal extension Array {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript(safe index: Int ) -> Element? {
    return indices.contains(index) ? self[index] : nil  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  }
}
  /*
internal extension Collection {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript (safe index: Index) -> Generator.Element? {
    let val = self[index];
    return self.indices ~= index ? self[index] : nil;
    
    return indices.contains(index) ? self[index] : nil
  }
}
*/
