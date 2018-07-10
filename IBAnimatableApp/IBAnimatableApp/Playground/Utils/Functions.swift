//
//  Created by Mark Hamilton on 4/9/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import Foundation

// Source: https://gist.github.com/TheDarkCode/2f65c1a25d5886ed210c3b33d73fe8a9
// Based on earlier version: http://stackoverflow.com/a/28341290/749786
#if swift(>=4.2)
func iterateEnum<T: CaseIterable>(_ from: T.Type) -> AnyIterator<T> {
	return AnyIterator(T.allCases.makeIterator())
}
#else
func iterateEnum<T: Hashable>(_ from: T.Type) -> AnyIterator<T> {
  var x = 0
  return AnyIterator {
    let next = withUnsafePointer(to: &x) {
      $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
    }
    defer {
      x += 1
    }
    return next.hashValue == x ? next : nil
  }
}
#endif
