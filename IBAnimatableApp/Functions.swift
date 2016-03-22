//
//  Created by Jake Lin on 3/1/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import Foundation

// http://stackoverflow.com/a/28341290/749786
func iterateEnum<T: Hashable>(_: T.Type) -> AnyGenerator<T> {
  var i = 0
  return AnyGenerator {
    let next = withUnsafePointer(&i) { UnsafePointer<T>($0).memory }
    let currentI = i
    i = i + 1
    return next.hashValue == currentI ? next : nil
  }
}
