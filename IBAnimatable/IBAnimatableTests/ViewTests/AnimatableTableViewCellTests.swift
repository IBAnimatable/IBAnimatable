//
//  AnimatableTableViewCellTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableTableViewCellTests: XCTestCase {

  var animatableTableViewCell: AnimatableTableViewCell!

  override func setUp() {
    super.setUp()
    animatableTableViewCell = AnimatableTableViewCell()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableTableViewCellTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius(animatableTableViewCell)
  }

  func test_cornerSides() {
    _test_cornerSides(animatableTableViewCell)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableTableViewCellTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableTableViewCell)
  }

  func testOpacity() {
    _testOpacity(animatableTableViewCell)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableTableViewCell)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableTableViewCell)
  }

}
