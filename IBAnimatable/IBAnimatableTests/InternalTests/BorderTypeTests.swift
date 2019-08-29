//
//  BorderTypeTests.swift
//  IBAnimatableTests
//
//  Created by phimage on 07/05/2019.
//  Copyright © 2019 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable
final class BorderTypeTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testBorderType() {
    let types: [String: BorderType] = [
      "solid": .solid,
      "dash": .dash(dashLength: 1, spaceLength: 1),
      "dash(10)": .dash(dashLength: 10, spaceLength: 1),
      "dash(10,10)": .dash(dashLength: 10, spaceLength: 10),
      "dash(10+10,10)": .dash(dashLength: 20, spaceLength: 10)
    ]

    for (string, expected) in types {
      let value = BorderType(string: string)
      XCTAssertEqual("\(value)", "\(expected)", string) // test string if `AnimationType` not equatable
    }
  }

}
