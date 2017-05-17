//
//  AnimatableCheckBoxTests.swift
//  IBAnimatable
//
//  Created by Steven on 5/12/17.
//  Copyright © 2017 IBAnimatable. All rights reserved.
//

import XCTest
@testable import IBAnimatable

final class AnimatableCheckBoxTests: XCTestCase {

  var animatableCheckBox: AnimatableCheckBox!

  override func setUp() {
    super.setUp()
    animatableCheckBox = AnimatableCheckBox()
  }

  override func tearDown() {
    super.tearDown()
  }

}

// MARK: - CornerDesignable Tests

extension AnimatableCheckBoxTests: CornerDesignableTests {

  func testCornerRadius() {
    _testCornerRadius(animatableCheckBox)
  }

  func test_cornerSides() {
    _test_cornerSides(animatableCheckBox)
  }

}

// MARK: - FillDesignable Tests

extension AnimatableCheckBoxTests: FillDesignableTests {

  func testFillColor() {
    _testFillColor(animatableCheckBox)
  }

  func testOpacity() {
    _testOpacity(animatableCheckBox)
  }

  func testPredefinedColor() {
    _testPredefinedColor(animatableCheckBox)
  }

  func test_predefinedColor() {
    _test_predefinedColor(animatableCheckBox)
  }

}
