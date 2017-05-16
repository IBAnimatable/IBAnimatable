//
//  AnimatableTableViewTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableTableViewTests: XCTestCase {

  var animatableTableView: AnimatableTableView!

  override func setUp() {
    super.setUp()
    animatableTableView = AnimatableTableView()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - FillDesignable Tests

extension AnimatableTableViewTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableTableView)
  }

  func testOpacity() {
    _testOpacity(animatableTableView)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableTableView)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableTableView)
  }

}
